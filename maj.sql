/*********************************************************delete all v******************************************************/
declare @procName varchar(500)
declare cur cursor
    for select [name] from sys.objects where type = 'v'
open cur

fetch next from cur into @procName
      while @@fetch_status = 0
      begin
                  exec('drop view ' + @procName)
                  fetch next from cur into @procName
      end
close cur
deallocate cur

go
/************************************************************table***********************************************************/
if not exists (select * from sysobjects where name='Version' and xtype='U')  
CREATE TABLE [dbo].[Version](
	[CleVersion] [int] IDENTITY(1,1) NOT NULL,
	[Version] [nvarchar](50) NULL
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='HistUG' and xtype='U')  
CREATE TABLE [dbo].[HistUG](
	[CleHistUG] [int] IDENTITY(1,1) NOT NULL,
	[CleProduit] [int] NULL,
	[UG] [float] NULL,
	[Date] [datetime] NULL,
	[CleUser] [int] NULL,
 CONSTRAINT [PK_HistUG] PRIMARY KEY CLUSTERED 
(
	[CleHistUG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='HistTiers' and xtype='U')  
CREATE TABLE [dbo].[HistTiers](
	[CleHistTiers] [int] IDENTITY(1,1) NOT NULL,
	[CleTiers] [int] NULL,
	[CleUser] [int] NULL,
	[Date] [datetime] NULL,
	[CleUsercreate] [int] NULL,
 CONSTRAINT [PK_HistTiers] PRIMARY KEY NONCLUSTERED 
(
	[CleHistTiers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
GO
if not exists (select * from sysobjects where name='CRMCommand' and xtype='U')  
CREATE TABLE [dbo].[CRMCommand](
	[CleCRMCommand] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[CleProduit] [int] NULL,
	[CleTiers] [int] NULL,
	[CleUser] [int] NULL,
 CONSTRAINT [PK_CRMCommand] PRIMARY KEY CLUSTERED 
(
	[CleCRMCommand] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Coefficient' and xtype='U')  
CREATE TABLE [dbo].[Coefficient](
	[CleCoefficient] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Libelle] [nvarchar](255) NULL,
	[Coefficient] [int] NULL,
	[Couleur] [int] NULL,
 CONSTRAINT [PK_Coefficient] PRIMARY KEY CLUSTERED 
(
	[CleCoefficient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='EffetQuota' and xtype='U')  
CREATE TABLE [dbo].[EffetQuota](
	[CleEffetQuota] [int] IDENTITY(1,1) NOT NULL,
	[CleEffet] [int] NULL,
	[CleLot] [int] NULL,
	[Qte1] [float] NULL,
	[Qte2] [float] NULL,
 CONSTRAINT [PK_EffetQuota] PRIMARY KEY CLUSTERED 
(
	[CleEffetQuota] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='HistQuota' and xtype='U')  
CREATE TABLE [dbo].[HistQuota](
	[CleHistQuota] [int] IDENTITY(1,1) NOT NULL,
	[CleProduit] [int] NULL,
	[bQuota] [bit] NULL,
	[Date] [datetime] NULL,
	[Date2] [datetime] NULL,
 CONSTRAINT [PK_HistQuota] PRIMARY KEY CLUSTERED 
(
	[CleHistQuota] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='HistoriqueLot' and xtype='U')  
 begin
CREATE TABLE [dbo].[HistoriqueLot](
	[CleHistoriqueLot] [int] IDENTITY(1,1) NOT NULL,
	[CleLot] [int] NULL,
	[Quantite] [float] NULL,
 CONSTRAINT [PK_HistoriqueLot] PRIMARY KEY CLUSTERED 
(
	[CleHistoriqueLot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
INSERT INTO HistoriqueLot(Quantite,CleLot) SELECT 0 AS Expr1, dbo.Lot.CleLot AS Expr2 FROM dbo.Lot
 end
GO
if not exists (select * from sysobjects where name='QuotaAvanceHist' and xtype='U')  
CREATE TABLE [dbo].[QuotaAvanceHist](
	[CleQuota] [int] IDENTITY(1,1) NOT NULL,
	[Type] [int] NULL DEFAULT ((0)),
	[CleProduit] [int] NULL,
	[CleLot] [int] NULL,
	[CleTiers] [int] NULL,
	[CleUser] [int] NULL,
	[Quantite] [float] NULL,
	[bManuelle] [bit] NULL DEFAULT ((0)),
	[Date] [datetime] NULL DEFAULT (getdate())
CONSTRAINT [PK_QuotaAvanceHist] PRIMARY KEY CLUSTERED 
(
	[CleQuota] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='QuotaAvance' and xtype='U')  
CREATE TABLE [dbo].[QuotaAvance](
	[CleQuota] [int] IDENTITY(1,1) NOT NULL,
	[Type] [int] NULL,
	[CleProduit] [int] NULL,
	[CleLot] [int] NULL,
	[CleTiers] [int] NULL,
	[CleUser] [int] NULL,
	[Quantite] [float] NULL,
	[bManuelle] [bit] NULL DEFAULT ((0)),
	[bactif] [bit] NULL DEFAULT ((1)),
CONSTRAINT [PK_QuotaAvance] PRIMARY KEY CLUSTERED 
(
	[CleQuota] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='HistCoeff' and xtype='U')  
CREATE TABLE [dbo].[HistCoeff](
	[CleHistCoeff] [int] IDENTITY(1,1) NOT NULL,
	[CleLot] [int] NULL,
	[Coeff] [int] NULL,
	[Date] [datetime] NULL,
	[CleUser] [int] NULL,
 CONSTRAINT [PK_HistCoeff] PRIMARY KEY CLUSTERED 
(
	[CleHistCoeff] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Form' and xtype='U')  
CREATE TABLE [dbo].[Form](
	[CleForm] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Form] [nvarchar](50) NULL,
 CONSTRAINT [PK_Form] PRIMARY KEY CLUSTERED 
(
	[CleForm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='CRM' and xtype='U')  
CREATE TABLE [dbo].[CRM](
	[CleCRM] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[CleUser] [int] NULL,
	[bUserDefaut] [bit] NULL DEFAULT ((1)),
	[CleTiers] [int] NULL,
	[Matin] [time](7) NULL,
	[Midi] [time](7) NULL,
	[Soir] [time](7) NULL,	
	[ObsPayement] [nvarchar](255) NULL,
	[FeedBack] [nvarchar](255) NULL,
	[CreateDate] [datetime] NULL,
	[CleUserCreate] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[CleUserModify] [int] NULL,	
 CONSTRAINT [PK_CRM] PRIMARY KEY CLUSTERED 
(
	[CleCRM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='TiersClasse' and xtype='U')  
CREATE TABLE [dbo].[TiersClasse](
	[CleTiersClasse] [int] IDENTITY(1,1) NOT NULL,
	[CleTiers] [int] NULL,
	[CleClasse] [int] NULL,
	[Observation] [nvarchar](255) NULL,
 CONSTRAINT [PK_TiersClasse] PRIMARY KEY CLUSTERED 
(
	[CleTiersClasse] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Classe' and xtype='U')  
CREATE TABLE [dbo].[Classe](
	[CleClasse] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Classe] [nvarchar](255) NULL,
 CONSTRAINT [PK_Classe] PRIMARY KEY CLUSTERED 
(
	[CleClasse] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

if not exists (select * from sysobjects where name='InventaireRapide' and xtype='U')    
CREATE TABLE [dbo].[InventaireRapide](
	[CleInventaireRapide] [int] IDENTITY(1,1) NOT NULL,
	[CleLot] [int] NULL,
	[CleEffet] [int] NULL,
	[Quantite] [float] NULL,
	[CleUser] [int] NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_InventaireRapide] PRIMARY KEY CLUSTERED 
(
	[CleInventaireRapide] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='AffectationInvestissement' and xtype='U')
 CREATE TABLE [dbo].[AffectationInvestissement](
	[CleAffectationInvestissement] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[AffectationInvestissement] [nvarchar](255) NULL,
	[Couleur] [int] NULL DEFAULT ((16777215)),
 CONSTRAINT [aaaaaAffectationInvestissement_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleAffectationInvestissement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Amortissement' and xtype='U')
 CREATE TABLE [dbo].[Amortissement](
	[CleAmortissement] [int] IDENTITY(1,1) NOT NULL,
	[CleCompte] [int] NULL,
	[CleInvestissement] [int] NULL,
	[Date] [datetime] NULL,
	[Montant] [money] NULL
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Borderau' and xtype='U')
 CREATE TABLE [dbo].[Borderau](
	[CleBorderau] [int] IDENTITY(1,1) NOT NULL,
	[Borderau] [varchar](50) NULL,
	[Date] [datetime] NULL,
	[Montant] [money] NULL,
	[Payement] [money] NULL,
	[Date2] [datetime] NULL,
	[Note] [varchar](500) NULL,
	[CleUser] [int] NULL,
	[CleUserModify] [int] NULL,
	[DateCreation] [datetime] NULL,
	[DateModification] [datetime] NULL,
 CONSTRAINT [PK_Borderau] PRIMARY KEY CLUSTERED 
(
	[CleBorderau] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='CategorieCompte' and xtype='U')
 CREATE TABLE [dbo].[CategorieCompte](
	[CleCategorieCompte] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[CategorieCompte] [nvarchar](100) NULL,
	[Couleur] [int] NULL CONSTRAINT [DF__Categorie__Coule__66361833]  DEFAULT ((16777215)),
 CONSTRAINT [aaaaaCategorieCompte_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleCategorieCompte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Convention' and xtype='U')
 CREATE TABLE [dbo].[Convention](
	[CleConvention] [int] IDENTITY(1,1) NOT NULL,
	[CleTypeConvention] [int] NULL,
	[Reference] [nvarchar](20) NULL,
	[Date] [datetime] NULL,
	[CleTiers] [int] NULL,
	[Signataire] [nvarchar](50) NULL,
	[SignataireFrs] [nvarchar](50) NULL,
	[Debut] [datetime] NULL,
	[Fin] [datetime] NULL,
	[ClePeriode] [int] NULL,
	[bLabo] [bit] NULL,
	[DelaiReclamation] [int] NULL,
	[DelaiRejet] [int] NULL,
	[MotifRejet] [nvarchar](50) NULL,
	[bLivraison] [bit] NULL,
	[Penalite] [float] NULL,
	[PenaliteLibelle] [nvarchar](255) NULL,
	[bPerime] [bit] NULL,
	[TauxMaxPerime] [float] NULL,
	[PerimeLibelle] [nvarchar](255) NULL,
	[Suivi] [int] NULL,
	[Note] [nvarchar](max) NULL,
	[Cloture] [bit] NULL,
	[CleUser] [int] NULL,
	[CleUserModified] [int] NULL,
	[CreateDate] [datetime] NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Convention] PRIMARY KEY CLUSTERED 
(
	[CleConvention] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
if not exists (select * from sysobjects where name='ConventionEcheance' and xtype='U')
 CREATE TABLE [dbo].[ConventionEcheance](
	[CleConventionEcheance] [int] IDENTITY(1,1) NOT NULL,
	[CleConvention] [int] NULL,
	[Echeance] [int] NULL,
	[Montant] [money] NULL,
	[Mode] [nvarchar](255) NULL,
 CONSTRAINT [PK_ConventionEcheance] PRIMARY KEY CLUSTERED 
(
	[CleConventionEcheance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='ConventionPalier' and xtype='U')
 CREATE TABLE [dbo].[ConventionPalier](
	[CleConventionPalier] [int] IDENTITY(1,1) NOT NULL,
	[CleConvention] [int] NULL,
	[Gamme] [nvarchar](50) NULL,
	[Montant] [money] NULL,
	[Ristourne] [float] NULL,
	[bObjectif] [bit] NULL,
	[RistourneSupp] [float] NULL,
 CONSTRAINT [PK_ConventionPalier] PRIMARY KEY CLUSTERED 
(
	[CleConventionPalier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Classeur' and xtype='U')
 CREATE TABLE [dbo].[Classeur](
	[CleClasseur] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Classeur] [varchar](100) NULL,
 CONSTRAINT [PK_Classeur] PRIMARY KEY CLUSTERED 
(
	[CleClasseur] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='DetailConvention' and xtype='U')
 CREATE TABLE [dbo].[DetailConvention](
	[CleDetailConvention] [int] IDENTITY(1,1) NOT NULL,
	[CleConvention] [int] NULL,
	[CleProduit] [int] NULL,
	[Gamme] [nvarchar](10) NULL,
	[RistourneSupp] [float] NULL,
	[Montant] [money] NULL,
 CONSTRAINT [PK_DetailConvention] PRIMARY KEY CLUSTERED 
(
	[CleDetailConvention] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='StatutTiers' and xtype='U')
 CREATE TABLE [dbo].[StatutTiers](
	[CleStatutTiers] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](20) NULL,
	[StatutTiers] [nvarchar](50) NULL,
 CONSTRAINT [PK_StatutTiers] PRIMARY KEY CLUSTERED 
(
	[CLeStatutTiers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='DetailEcriture' and xtype='U')
 CREATE TABLE [dbo].[DetailEcriture](
	[CleDetailEcriture] [int] IDENTITY(1,1) NOT NULL,
	[CleEcriture] [int] NULL,
	[NbLigne] [int] NULL,
	[Compte] [int] NULL,
	[SousCompte] [nvarchar](8) NULL,
	[Libelle] [nvarchar](100) NULL,
	[NbDoc] [nvarchar](50) NULL,
	[Debit] [money] NULL,
	[Credit] [money] NULL,
	[Journal] [int] NULL,
	[CleJournal] [int] NULL,
 CONSTRAINT [PK_DetailEcriture] PRIMARY KEY CLUSTERED 
(
	[CleDetailEcriture] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='DetailRatioTiers' and xtype='U')
 CREATE TABLE [dbo].[DetailRatioTiers](
	[CleDetailRatio] [int] IDENTITY(1,1) NOT NULL,
	[CleTiers] [int] NULL,
	[RChiffre] [float] NULL,
	[RPayement] [float] NULL,
	[RBalayage] [float] NULL,
	[RFrequence] [float] NULL,
	[RMarge] [float] NULL,
	[Chiffre] [money] NULL,
	[Payement] [money] NULL,
	[Balayage] [int] NULL,
	[Frequence] [int] NULL,
	[Marge] [money] NULL,
	[Ratio] [float] NULL,
	[Date] [datetime] NULL,
	[RProduit] [float] NULL,
	[Produit] [money] NULL,
 CONSTRAINT [PK_DetailRatioTiers] PRIMARY KEY CLUSTERED 
(
	[CleDetailRatio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Echeance' and xtype='U')
 CREATE TABLE [dbo].[Echeance](
	[CleEcheance] [int] IDENTITY(1,1) NOT NULL,
	[Libelle] [nvarchar](255) NULL,
	[Montant] [money] NULL,
	[Echeance] [int] NULL,
 CONSTRAINT [PK_Echeance] PRIMARY KEY CLUSTERED 
(
	[CleEcheance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Ecriture' and xtype='U')
 CREATE TABLE [dbo].[Ecriture](
	[CleEcriture] [int] IDENTITY(1,1) NOT NULL,
	[Reference] [varchar](50) NULL,
	[Date] [datetime] NULL,
	[NbPiece] [varchar](50) NULL,
	[CleJournal] [int] NULL,
	[CleClasseur] [int] NULL,
	[NbLigne] [int] NULL,
	[Debit] [money] NULL,
	[Credit] [money] NULL,
	[CleUser] [int] NULL,
	[CleUserModified] [int] NULL,
	[CreateDate] [datetime] NULL,
	[LastModifiedDate] [datetime] NULL,
	[bLiaison] [bit] NULL CONSTRAINT [DF_Ecriture_bLiaison]  DEFAULT ((0)),
	[Cloture] [bit] NULL CONSTRAINT [DF_Ecriture_Cloture]  DEFAULT ((0)),
	[CleEntreprise] [int] NULL,
	[Jour] [int] NULL,
	[CleJour] [int] NULL,
 CONSTRAINT [PK_Ecriture] PRIMARY KEY CLUSTERED 
(
	[CleEcriture] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Comptabilite' and xtype='U')
 CREATE TABLE [dbo].[Comptabilite](
	[CleComptabilite] [int] IDENTITY(1,1) NOT NULL,
	[Source] [nvarchar](50) NULL,
	[Methode] [int] NULL,
	[Extension] [int] NULL,
	[Extension2] [int] NULL,
	[bLibelle] [bit] NULL,
	[Libelle] [nvarchar](255) NULL,
	[Journal] [int] NULL,
	[Detail] [nvarchar](50) NULL,
	[Compte] [nvarchar](50) NULL,
	[CleTiers] [nvarchar](50) NULL,
	[CleMode] [int] NULL,
	[EgJournal] [int] NULL,
 CONSTRAINT [PK_Comptabilite] PRIMARY KEY CLUSTERED 
(
	[CleComptabilite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='ConventionDetailPalier' and xtype='U')
 CREATE TABLE [dbo].[ConventionDetailPalier](
	[CleConventionDetailPalier] [int] IDENTITY(1,1) NOT NULL,
	[CleConvention] [int] NULL,
	[Code] [int] NULL,
	[Tranche] [float] NULL,
	[Ristourne] [float] NULL,
 CONSTRAINT [PK_ConventionDetailPalier] PRIMARY KEY CLUSTERED 
(
	[CleConventionDetailPalier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='ConventionFournisseur' and xtype='U')
 CREATE TABLE [dbo].[ConventionFournisseur](
	[CleConventionFournisseur] [int] IDENTITY(1,1) NOT NULL,
	[CleConvention] [int] NULL,
	[CleTiers] [int] NULL,
 CONSTRAINT [PK_ConventionFournisseur] PRIMARY KEY CLUSTERED 
(
	[CleConventionFournisseur] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='ConventionRistourne' and xtype='U')
 CREATE TABLE [dbo].[ConventionRistourne](
	[CleConventionRistourne] [int] IDENTITY(1,1) NOT NULL,
	[CleConvention] [int] NULL,
	[Gamme] [nvarchar](50) NULL,
	[Montant] [money] NULL,
	[Ristourne] [float] NULL,
 CONSTRAINT [PK_ConventionRistourne] PRIMARY KEY CLUSTERED 
(
	[CleConventionRistourne] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='DetailAvoir' and xtype='U')
 CREATE TABLE [dbo].[DetailAvoir](
	[CleDetailAvoir] [int] IDENTITY(1,1) NOT NULL,
	[Libelle] [nvarchar](255) NULL,
	[Tranche] [money] NULL DEFAULT ((0)),
	[CleEffet] [int] NULL DEFAULT ((0)),
	[CleEffetCharge] [int] NULL DEFAULT ((0)),
 CONSTRAINT [aaaaaDetailAvoir_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleDetailAvoir] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='DetailConvention' and xtype='U')
 CREATE TABLE [dbo].[DetailConvention](
	[CleDetailConvention] [int] IDENTITY(1,1) NOT NULL,
	[CleConvention] [int] NULL,
	[CleProduit] [int] NULL,
	[Gamme] [nvarchar](10) NULL,
	[RistourneSupp] [float] NULL,
	[Montant] [money] NULL,
 CONSTRAINT [PK_DetailConvention] PRIMARY KEY CLUSTERED 
(
	[CleDetailConvention] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='DetailEcriture' and xtype='U')
 CREATE TABLE [dbo].[DetailEcriture](
	[CleDetailEcriture] [int] IDENTITY(1,1) NOT NULL,
	[CleEcriture] [int] NULL,
	[NbLigne] [int] NULL,
	[Compte] [int] NULL,
	[SousCompte] [nvarchar](8) NULL,
	[Libelle] [nvarchar](100) NULL,
	[NbDoc] [nvarchar](50) NULL,
	[Debit] [money] NULL,
	[Credit] [money] NULL,
	[Journal] [int] NULL,
	[CleJournal] [int] NULL,
 CONSTRAINT [PK_DetailEcriture] PRIMARY KEY CLUSTERED 
(
	[CleDetailEcriture] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='DocConvention' and xtype='U')
 CREATE TABLE [dbo].[DocConvention](
	[CleDocConvention] [int] IDENTITY(1,1) NOT NULL,
	[CleConvention] [int] NULL DEFAULT ((0)),
	[Libelle] [nvarchar](50) NULL,
	[Path] [nvarchar](255) NULL,
 CONSTRAINT [aaaaaDocConvention_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleDocConvention] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='EtatImpression' and xtype='U')
 CREATE TABLE [dbo].[EtatImpression](
	[CleEtatImpression] [int] IDENTITY(1,1) NOT NULL,
	[CleEtat] [int] NULL,
	[CleTable] [int] NULL,
	[CleValue] [nvarchar](10) NULL,
	[Colonne] [nvarchar](50) NULL,
	[Value] [nvarchar](200) NULL,
	[Formule] [nvarchar](max) NULL,
	[Formule2] [nvarchar](max) NULL,
	[bPrecedent] [int] NULL CONSTRAINT [DF_EtatImpression_bPrecedent]  DEFAULT ((0)),
	[Exercice] [int] NULL CONSTRAINT [DF_EtatImpression_Exercice]  DEFAULT ((0)),
 CONSTRAINT [PK_EtatImpression] PRIMARY KEY CLUSTERED 
(
	[CleEtatImpression] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='EtatOpComptoir' and xtype='U')
 CREATE TABLE [dbo].[EtatOpComptoir](
	[CleEtatOpComptoir] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](20) NULL,
	[EtatOpComptoir] [nvarchar](100) NULL,
	[Couleur] [int] NULL DEFAULT ((16777215)),
	[bInstance] [bit] NULL CONSTRAINT [DF_EtatOpComptoir_bInstance]  DEFAULT ((0)),
	[bAdmin] [bit] NULL CONSTRAINT [DF_EtatOpComptoir_bAdmin]  DEFAULT ((0)),
 CONSTRAINT [aaaaaEtatOpComptoir_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleEtatOpComptoir] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Investissement' and xtype='U')
 CREATE TABLE [dbo].[Investissement](
	[CleInvestissement] [int] IDENTITY(1,1) NOT NULL,
	[Compte] [int] NULL,
	[CompteAmortissement] [int] NULL,
	[CompteDotation] [int] NULL,
	[CleTypeInvestissement] [int] NULL,
	[Code] [nvarchar](50) NULL,
	[Libelle] [varchar](100) NULL,
	[DateMiseService] [datetime] NULL,
	[Quantite] [float] NULL,
	[DateAquisition] [datetime] NULL,
	[CleTypeAquisition] [int] NULL,
	[Valeur] [money] NULL,
	[DateSortie] [datetime] NULL,
	[CleTypeSortie] [int] NULL,
	[TauxAmortissement] [float] NULL,
	[CleTypeAmortissement] [int] NULL,
	[CleAffectation] [int] NULL,
 CONSTRAINT [PK_Investissement] PRIMARY KEY CLUSTERED 
(
	[CleInvestissement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Journal' and xtype='U')
 CREATE TABLE [dbo].[Journal](
	[CleJournal] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Libelle] [nvarchar](100) NULL,
	[NbPiece] [int] NULL,
	[Prefix] [nvarchar](50) NULL,
	[Size] [int] NULL,
 CONSTRAINT [PK_Journal] PRIMARY KEY CLUSTERED 
(
	[CleJournal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='ListingFournisseur' and xtype='U')
 CREATE TABLE [dbo].[ListingFournisseur](
	[CleListingFournisseur] [int] IDENTITY(1,1) NOT NULL,
	[CleProduit] [int] NULL,
	[CleTiers] [int] NULL,
	[Libelle] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_ListingFournisseur] PRIMARY KEY CLUSTERED 
(
	[CleListingFournisseur] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='NatureCompte' and xtype='U')
 CREATE TABLE [dbo].[NatureCompte](
	[CleNatureCompte] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[NatureCompte] [nvarchar](255) NULL,
	[Couleur] [int] NULL DEFAULT ((16777215)),
 CONSTRAINT [aaaaaNatureCompte_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleNatureCompte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
if not exists (select * from sysobjects where name='OrdonnancierInstance' and xtype='U')
 CREATE TABLE [dbo].[OrdonnancierInstance](
	[CleOrdonnancier] [int] IDENTITY(1,1) NOT NULL,
	[Ref] [nvarchar](12) NULL,
	[Date] [datetime] NULL,
	[Ordonnateur] [nvarchar](255) NULL,
	[Client] [nvarchar](255) NULL,
	[Adresse] [nvarchar](255) NULL,
	[Notes] [ntext] NULL,
	[Locked] [bit] NULL CONSTRAINT [DF_OrdonnancierInstance_Locked]  DEFAULT ((0)),
 CONSTRAINT [aaaaaOrdonnancierInstance_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleOrdonnancier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='ParametreCompta' and xtype='U')
 CREATE TABLE [dbo].[ParametreCompta](
	[CleParametre] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Valeur] [numeric](18, 0) NULL,
	[Valeur2] [nvarchar](200) NULL,
	[Valeur3] [bit] NULL,
 CONSTRAINT [PK_ParametreCompta] PRIMARY KEY CLUSTERED 
(
	[CleParametre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='PrixVente' and xtype='U')
 CREATE TABLE [dbo].[PrixVente](
	[ClePrixVente] [int] IDENTITY(1,1) NOT NULL,
	[CleTarif] [int] NULL DEFAULT ((0)),
	[CleLot] [int] NULL DEFAULT ((0)),
	[PrixVente] [money] NULL DEFAULT ((0)),
 CONSTRAINT [aaaaaPrixVente_PK] PRIMARY KEY NONCLUSTERED 
(
	[ClePrixVente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='ProfileCompta' and xtype='U')
 CREATE TABLE [dbo].[ProfileCompta](
	[CleProfile] [int] IDENTITY(1,1) NOT NULL,
	[Profile] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProfileCompta] PRIMARY KEY CLUSTERED 
(
	[CleProfile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='Plan' and xtype='U')
 CREATE TABLE [dbo].[Plan](
	[ClePlan] [int] IDENTITY(1,1) NOT NULL,
	[NbCompte] [int] NULL,
	[Libelle] [nvarchar](255) NULL,
	[LibelleArabe] [nvarchar](255) NULL,
	[CleStatut] [int] NULL,
	[CleNature] [int] NULL,
	[CleCategorie] [int] NULL,
	[Debit] [money] NULL,
	[Credit] [money] NULL,
	[bSousCompte] [bit] NULL,
	[CleTypeCompte] [int] NULL,
	[bDebit] [bit] NULL,
	[bCredit] [bit] NULL,
 CONSTRAINT [PK_Plan] PRIMARY KEY CLUSTERED 
(
	[ClePlan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='SousCompte' and xtype='U')
 CREATE TABLE [dbo].[SousCompte](
	[CleSousCompte] [int] IDENTITY(1,1) NOT NULL,
	[CleCompte] [int] NULL,
	[NbCompte] [varchar](50) NULL,
	[NbSousCompte] [varchar](50) NULL,
	[Libelle] [varchar](100) NULL,
	[LibelleArabe] [varchar](100) NULL,
	[Debit] [money] NULL,
	[Credit] [money] NULL,
 CONSTRAINT [PK_SousCompte] PRIMARY KEY CLUSTERED 
(
	[CleSousCompte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='StatutCompte' and xtype='U')
 begin
CREATE TABLE [dbo].[StatutCompte](
	[CleStatutCompte] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[StatutCompte] [nvarchar](100) NULL,
	[Couleur] [int] NULL,
 CONSTRAINT [aaaaaStatutCompte_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleStatutCompte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[StatutCompte] ADD  CONSTRAINT [DF__StatutCom__Coule__1308BEAA]  DEFAULT ((16777215)) FOR [Couleur]
end
GO
if not exists (select * from sysobjects where name='TmpBalance' and xtype='U')
 CREATE TABLE [dbo].[TmpBalance](
	[Exo] [int] NULL,
	[Compte] [int] NULL,
	[ODebit] [money] NULL,
	[Ocredit] [money] NULL,
	[EDebit] [money] NULL,
	[ECredit] [money] NULL,
	[CleEntreprise] [int] NULL CONSTRAINT [DF_TmpBalance_CleEntreprise]  DEFAULT ((1)),
	[Grouper] [nvarchar](50) NULL
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='TmpBalanceCptTiers' and xtype='U')
 CREATE TABLE [dbo].[TmpBalanceCptTiers](
	[Exo] [int] NULL,
	[Compte] [int] NULL,
	[Auxiliaire] [nvarchar](8) NULL,
	[ODebit] [money] NULL,
	[OCredit] [money] NULL,
	[EDebit] [money] NULL,
	[ECredit] [money] NULL,
	[CleEntreprise] [int] NULL CONSTRAINT [DF_TmpBalanceCptTiers_CleEntreprise]  DEFAULT ((1)),
	[Grouper] [nvarchar](50) NULL
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='TmpBalanceTiers' and xtype='U')
 CREATE TABLE [dbo].[TmpBalanceTiers](
	[Exo] [int] NULL,
	[Auxiliaire] [nvarchar](8) NULL,
	[ODebit] [money] NULL,
	[OCredit] [money] NULL,
	[EDebit] [money] NULL,
	[ECredit] [money] NULL,
	[CleEntreprise] [int] NULL CONSTRAINT [DF_TmpBalanceTiers_CleEntreprise]  DEFAULT ((1))
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='TmpCreance' and xtype='U')
 CREATE TABLE [dbo].[TmpCreance](
	[CleTiers] [int] NOT NULL,
	[Solde] [money] NULL
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='TmpGL' and xtype='U')
 CREATE TABLE [dbo].[TmpGL](
	[Compte] [int] NULL,
	[Exo] [int] NULL,
	[Debit] [money] NULL,
	[Credit] [money] NULL
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='TmpGLCptTiers' and xtype='U')
 CREATE TABLE [dbo].[TmpGLCptTiers](
	[Compte] [int] NULL,
	[SousCompte] [nvarchar](8) NULL,
	[Exo] [int] NULL,
	[Debit] [money] NULL,
	[Credit] [money] NULL
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='TmpGLTiers' and xtype='U')
 CREATE TABLE [dbo].[TmpGLTiers](
	[Compte] [nvarchar](8) NULL,
	[Exo] [int] NULL,
	[Debit] [money] NULL,
	[Credit] [money] NULL
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='TypeAmortissement' and xtype='U')
 CREATE TABLE [dbo].[TypeAmortissement](
	[CleTypeAmortissement] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[TypeAmortissement] [nvarchar](255) NULL,
	[Couleur] [int] NULL DEFAULT ((16777215)),
 CONSTRAINT [aaaaaTypeAmortissement_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleTypeAmortissement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='TypeAquisition' and xtype='U')
 begin
CREATE TABLE [dbo].[TypeAquisition](
	[CleTypeAquisition] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[TypeAquisition] [nvarchar](255) NULL,
	[Couleur] [int] NULL,
 CONSTRAINT [aaaaaTypeAquisition_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleTypeAquisition] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[TypeAquisition] ADD  DEFAULT ((16777215)) FOR [Couleur]
end
GO
if not exists (select * from sysobjects where name='TypeCharge' and xtype='U')
 CREATE TABLE [dbo].[TypeCharge](
	[CleTypeCharge] [int] IDENTITY(1,1) NOT NULL,
	[TypeCharge] [nvarchar](50) NULL,
	[Code] [nvarchar](50) NULL,
	[CleParent] [int] NULL,
	[Hierarchy] [nvarchar](255) NULL,
	[Depth] [int] NULL CONSTRAINT [DF_TypeCharge_Depth]  DEFAULT ((1)),
 CONSTRAINT [aaaaaTypeCharge_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleTypeCharge] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='TypeCompte' and xtype='U')
 CREATE TABLE [dbo].[TypeCompte](
	[CleTypeCompte] [int] IDENTITY(1,1) NOT NULL,
	[TypeCompte] [varchar](50) NULL,
 CONSTRAINT [PK_TypeCompte] PRIMARY KEY CLUSTERED 
(
	[CleTypeCompte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='TypeInvestissement' and xtype='U')
 begin
CREATE TABLE [dbo].[TypeInvestissement](
	[CleTypeInvestissement] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[TypeInvestissement] [nvarchar](255) NULL,
	[Couleur] [int] NULL,
 CONSTRAINT [aaaaaTypeInvestissement_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleTypeInvestissement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[TypeInvestissement] ADD  DEFAULT ((16777215)) FOR [Couleur]
end
GO
if not exists (select * from sysobjects where name='TypeSortie' and xtype='U')
 begin
CREATE TABLE [dbo].[TypeSortie](
	[CleTypeSortie] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[TypeSortie] [nvarchar](255) NULL,
	[Couleur] [int] NULL,
 CONSTRAINT [aaaaaTypeSortie_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleTypeSortie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[TypeSortie] ADD  DEFAULT ((16777215)) FOR [Couleur]
end
GO
if not exists (select * from sysobjects where name='UserIdentification' and xtype='U')
 CREATE TABLE [dbo].[UserIdentification](
	[CleUserIdentification] [int] IDENTITY(1,1) NOT NULL,
	[CleUser] [int] NULL,
	[Date] [datetime] NULL,
	[Poste] [nvarchar](100) NULL,
	[Session] [nvarchar](100) NULL,
 CONSTRAINT [PK_UserIdentification] PRIMARY KEY CLUSTERED 
(
	[CleUserIdentification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UserProfileCompta' and xtype='U')
 CREATE TABLE [dbo].[UserProfileCompta](
	[CleUserProfile] [int] IDENTITY(1,1) NOT NULL,
	[CleUser] [int] NULL,
	[CleProfile] [int] NULL,
	[Valeur] [bit] NULL,
 CONSTRAINT [PK_UserProfileCompta] PRIMARY KEY CLUSTERED 
(
	[CleUserProfile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpAffectation' and xtype='U')
 CREATE TABLE [dbo].[UpAffectation](
	[CleAffectation] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Affectation] [nvarchar](250) NULL,
	[AffectationArabe] [nvarchar](250) NULL,
 CONSTRAINT [PK_sAffectation] PRIMARY KEY CLUSTERED 
(
	[CleAffectation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpAgence' and xtype='U')
 CREATE TABLE [dbo].[UpAgence](
	[CleAgence] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Agence] [nvarchar](250) NULL,
	[AgenceArabe] [nvarchar](250) NULL,
	[Compte] [nvarchar](50) NULL,
 CONSTRAINT [PK_UpAgence] PRIMARY KEY CLUSTERED 
(
	[CleAgence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpAppointment' and xtype='U')
 CREATE TABLE [dbo].[UpAppointment](
	[CleAppointement] [int] IDENTITY(1,1) NOT NULL,
	[Type] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[AllDay] [bit] NULL,
	[Subject] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [int] NULL,
	[Label] [int] NULL,
	[CleUser] [int] NULL,
	[ResourceIds] [nvarchar](255) NULL,
	[ReminderInfo] [nvarchar](255) NULL,
	[RecurrenceInfo] [nvarchar](255) NULL,
	[PercentComplete] [int] NULL,
	[TimeZoneId] [nvarchar](255) NULL,
	[CustomField1] [nvarchar](255) NULL,
 CONSTRAINT [PK_UpAppointments] PRIMARY KEY CLUSTERED 
(
	[CleAppointement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpCategorieDoc' and xtype='U')
 CREATE TABLE [dbo].[UpCategorieDoc](
	[CleCategorieDoc] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[CategorieDoc] [nvarchar](255) NULL,
	[Notes] [ntext] NULL,
	[Couleur] [int] NULL DEFAULT ((16777215)),
	[bPrintable] [bit] NULL DEFAULT ((1)),
 CONSTRAINT [CategorieDoc_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleCategorieDoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpDetailPaye' and xtype='U')
 CREATE TABLE [dbo].[UpDetailPaye](
	[CleDetailPaye] [int] IDENTITY(1,1) NOT NULL,
	[ClePaye] [int] NULL,
	[CleRubrique] [int] NULL,
	[Code] [nvarchar](50) NULL,
	[Rubrique] [nvarchar](250) NULL,
	[Base] [float] NULL,
	[Taux] [float] NULL,
	[Montant] [money] NULL,
 CONSTRAINT [PK_UpDetailPaye] PRIMARY KEY CLUSTERED 
(
	[CleDetailPaye] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpDocument' and xtype='U')
 CREATE TABLE [dbo].[UpDocument](
	[CleDocument] [int] IDENTITY(1,1) NOT NULL,
	[CleTypeDoc] [int] NULL,
	[Reference] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[CleUser] [int] NULL,
	[Motif] [ntext] NULL,
	[Debut] [datetime] NULL,
	[Fin] [datetime] NULL,
	[Note] [ntext] NULL,
	[CleCategorie] [int] NULL,
	[CleTypeContrat] [int] NULL,
	[Transport] [nvarchar](200) NULL,
	[CleAffectation] [int] NULL,
	[CleFonction] [int] NULL,
	[Base] [money] NULL,
	[CreateDate] [datetime] NULL,
	[LastModifiedDate] [datetime] NULL,
	[CleUserCreate] [int] NULL,
	[CleUserModify] [int] NULL,
 CONSTRAINT [PK_UpDocument] PRIMARY KEY CLUSTERED 
(
	[CleDocument] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpEtatCivil' and xtype='U')
 CREATE TABLE [dbo].[UpEtatCivil](
	[CleEtatCivil] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[EtatCivil] [nvarchar](250) NULL,
 CONSTRAINT [PK_UpEtatCivil] PRIMARY KEY CLUSTERED 
(
	[CleEtatCivil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpFonction' and xtype='U')
 CREATE TABLE [dbo].[UpFonction](
	[CleFonction] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Fonction] [nvarchar](250) NULL,
	[FonctionArabe] [nvarchar](250) NULL,
 CONSTRAINT [PK_UpFonction] PRIMARY KEY CLUSTERED 
(
	[CleFonction] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpGrille' and xtype='U')
 CREATE TABLE [dbo].[UpGrille](
	[CleGrille] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Grille] [nvarchar](100) NULL,
	[Categorie] [nvarchar](100) NULL,
	[Base] [money] NULL,
 CONSTRAINT [PK_UpGrille] PRIMARY KEY CLUSTERED 
(
	[CleGrille] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpHoraire' and xtype='U')
 CREATE TABLE [dbo].[UpHoraire](
	[CleHoraire] [int] IDENTITY(1,1) NOT NULL,
	[CleUser] [int] NULL,
	[Debut] [nvarchar](20) NULL,
	[Fin] [nvarchar](20) NULL,
 CONSTRAINT [PK_UpHoraire] PRIMARY KEY CLUSTERED 
(
	[CleHoraire] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpLabel' and xtype='U')
 CREATE TABLE [dbo].[UpLabel](
	[Label] [int] IDENTITY(1,1) NOT NULL,
	[Libelle] [nvarchar](50) NULL,
 CONSTRAINT [PK_UpLabel] PRIMARY KEY CLUSTERED 
(
	[Label] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpMode' and xtype='U')
 CREATE TABLE [dbo].[UpMode](
	[CleMode] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Mode] [nvarchar](250) NULL,
	[ModeArabe] [nvarchar](250) NULL,
	[Compte] [nvarchar](50) NULL,
 CONSTRAINT [PK_UpMode] PRIMARY KEY CLUSTERED 
(
	[CleMode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpMotifDepart' and xtype='U')
 CREATE TABLE [dbo].[UpMotifDepart](
	[CleMotifDepart] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[MotifDepart] [nvarchar](100) NULL,
 CONSTRAINT [PK_UpMotifDepart] PRIMARY KEY CLUSTERED 
(
	[CleMotifDepart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpParametre' and xtype='U')
 CREATE TABLE [dbo].[UpParametre](
	[CleParametre] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Valeur] [numeric](18, 0) NULL,
	[Valeur2] [nvarchar](200) NULL,
	[Valeur3] [bit] NULL,
 CONSTRAINT [PK_UpParametre] PRIMARY KEY CLUSTERED 
(
	[CleParametre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpPaye' and xtype='U')
 CREATE TABLE [dbo].[UpPaye](
	[ClePaye] [int] IDENTITY(1,1) NOT NULL,
	[Periode] [datetime] NULL,
	[CleUser] [int] NULL,
	[MontantNet] [money] NULL,
	[Conge] [float] NULL,
	[CongeConsomme] [float] NULL,
	[MontantConge] [money] NULL,
	[DateCreation] [datetime] NULL,
	[DateModification] [datetime] NULL,
	[CleUserCreation] [int] NULL,
	[CleUserModification] [int] NULL,
	[CleEntreprise] [int] NULL CONSTRAINT [DF_UpPaye_CleEntreprise]  DEFAULT ((1)),
 CONSTRAINT [PK_UpPaye] PRIMARY KEY CLUSTERED 
(
	[ClePaye] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpPointage' and xtype='U')
 CREATE TABLE [dbo].[UpPointage](
	[ClePointage] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[bEntree] [bit] NULL,
	[bSynch] [bit] NULL,
 CONSTRAINT [PK_Pointage] PRIMARY KEY CLUSTERED 
(
	[ClePointage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpPosition' and xtype='U')
 CREATE TABLE [dbo].[UpPosition](
	[ClePosition] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Position] [nvarchar](250) NULL,
	[PositionArabe] [nvarchar](250) NULL,
 CONSTRAINT [PK_UpPosition] PRIMARY KEY CLUSTERED 
(
	[ClePosition] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpRubrique' and xtype='U')
 CREATE TABLE [dbo].[UpRubrique](
	[CleRubrique] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Rubrique] [nvarchar](250) NULL,
	[RubriqueArabe] [nvarchar](250) NULL,
	[bSS] [bit] NULL,
	[bIRG] [bit] NULL,
	[bPositive] [bit] NULL,
	[bFixe] [bit] NULL,
	[Calcul] [int] NULL,
	[Taux] [money] NULL,
	[Limite] [money] NULL,
	[bAbsence] [bit] NULL,
	[bProrata] [bit] NULL,
	[bEcheance] [bit] NULL,
	[bNormal] [bit] NULL,
	[Base] [money] NULL,
	[CompteImputation] [nvarchar](50) NULL,
	[CompteContrePartie] [nvarchar](50) NULL,
	[NatureTiers] [int] NULL,
	[RubriqueRappel] [nvarchar](50) NULL,
	[RubriqueTropPercu] [nvarchar](50) NULL,
	[bConge] [bit] NULL,
 CONSTRAINT [PK_sRubrique] PRIMARY KEY CLUSTERED 
(
	[CleRubrique] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpServiceNational' and xtype='U')
 CREATE TABLE [dbo].[UpServiceNational](
	[CleServiceNational] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[ServiceNational] [nvarchar](100) NULL,
	[ServiceNationalArabe] [nvarchar](100) NULL,
 CONSTRAINT [PK_UpServiceNational] PRIMARY KEY CLUSTERED 
(
	[CleServiceNational] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpTypeContrat' and xtype='U')
 CREATE TABLE [dbo].[UpTypeContrat](
	[CleTypeContrat] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[TypeContrat] [nvarchar](100) NULL,
	[TypeContratArabe] [nvarchar](100) NULL,
 CONSTRAINT [PK_UpTypeContrat] PRIMARY KEY CLUSTERED 
(
	[CleTypeContrat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpTypeDoc' and xtype='U')
 CREATE TABLE [dbo].[UpTypeDoc](
	[CleTypeDoc] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[TypeDoc] [nvarchar](250) NULL,
	[TypeDocArabe] [nvarchar](250) NULL,
	[Prefix] [nvarchar](50) NULL,
	[Next] [int] NULL,
	[Size] [int] NULL,
	[bAuto] [bit] NULL,
 CONSTRAINT [PK_UpTypeDoc] PRIMARY KEY CLUSTERED 
(
	[CleTypeDoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpProfile' and xtype='U') 
CREATE TABLE [dbo].[UpProfile](
	[CleProfile] [int] IDENTITY(1,1) NOT NULL,
	[Profile] [nvarchar](50) NULL,
 CONSTRAINT [PK_UpProfile] PRIMARY KEY CLUSTERED 
(
	[CleProfile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UserProfilePaye' and xtype='U')
 CREATE TABLE [dbo].[UserProfilePaye](
	[CleUserProfile] [int] IDENTITY(1,1) NOT NULL,
	[CleUser] [int] NULL,
	[CleProfile] [int] NULL,
	[Valeur] [bit] NULL,
 CONSTRAINT [PK_UserProfilePaye] PRIMARY KEY CLUSTERED 
(
	[CleUserProfile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpTypeSalarie' and xtype='U')
 CREATE TABLE [dbo].[UpTypeSalarie](
	[CleTypeSalarie] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[TypeSalarie] [nvarchar](250) NULL,
 CONSTRAINT [PK_UpTypeSalarie] PRIMARY KEY CLUSTERED 
(
	[CleTypeSalarie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpDetailPayeType' and xtype='U')
 CREATE TABLE [dbo].[UpDetailPayeType](
	[CleDetailPayeType] [int] IDENTITY(1,1) NOT NULL,
	[CleUser] [int] NULL,
	[CleRubrique] [int] NULL,
	[Code] [nvarchar](50) NULL,
	[Rubrique] [nvarchar](250) NULL,
	[Base] [float] NULL,
	[Taux] [float] NULL,
	[Montant] [money] NULL,
 CONSTRAINT [PK_UpDetailPayeType] PRIMARY KEY CLUSTERED 
(
	[CleDetailPayeType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpPoint' and xtype='U')
CREATE TABLE [dbo].[UpPoint](
	[ClePoint] [int] IDENTITY(1,1) NOT NULL,
	[CleUser] [int] NULL,
	[Code] [nvarchar](50) NULL,
	[Date] [date] NULL,
	[Matin] [time](7) NULL,
	[Soir] [time](7) NULL,
	[Entree] [time](7) NULL,
	[Sortie] [time](7) NULL,
	[DebutPose] [time](7) NULL,
	[FinPose] [time](7) NULL,
	[bFerier] [bit] NULL,
	[bSyn] [bit] NULL,
	[AvisRH] [int] NULL,
	[AvisHierarchique] [int] NULL,
	[Ret] [time](7) NULL,
	[HS] [time](7) NULL,
	[HS2] [time](7) NULL,
	[Periode] [datetime] NULL,
 CONSTRAINT [PK_UpPoint] PRIMARY KEY CLUSTERED 
(
	[ClePoint] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
if not exists (select * from sysobjects where name='UpConge' and xtype='U')
 begin
 CREATE TABLE [dbo].[UpConge](
	[CleConge] [int] IDENTITY(1,1) NOT NULL,
	[CleUser] [int] NULL,
	[Jour] [float] NULL,
	[Montant] [money] NULL,
	[DateCreation] [datetime] NULL,
 CONSTRAINT [PK_UpConge] PRIMARY KEY CLUSTERED 
(
	[CleConge] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[UpConge] ADD  CONSTRAINT [DF_UpConge_DateCreation]  DEFAULT (getdate()) FOR [DateCreation]
 end
GO
if not exists (select * from sysobjects where name='UpDetailConge' and xtype='U')
 begin
CREATE TABLE [dbo].[UpDetailConge](
	[CleDetailConge] [int] IDENTITY(1,1) NOT NULL,
	[CleUser] [int] NULL,
	[Jour] [float] NULL,
	[Montant] [money] NULL,
	[DateCreation] [datetime] NULL,
	[DateModification] [datetime] NULL,
	[CleUserCreation] [int] NULL,
	[CleUserModification] [int] NULL,
 CONSTRAINT [PK_UpDetailConge] PRIMARY KEY CLUSTERED 
(
	[CleDetailConge] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[UpDetailConge] ADD  CONSTRAINT [DF_UpDetailConge_DateCreation]  DEFAULT (getdate()) FOR [DateCreation]
ALTER TABLE [dbo].[UpDetailConge] ADD  CONSTRAINT [DF_UpDetailConge_DateModification]  DEFAULT (getdate()) FOR [DateModification]
 end
GO
if not exists (select * from sysobjects where name='Colis' and xtype='U')
 begin
CREATE TABLE [dbo].[Colis](
	[CleColis] [int] IDENTITY(1,1) NOT NULL,
	[CleEffet] [int] NULL,
	[NbColis] [int] NULL,
	[NbFrigo] [int] NULL,
	[NbPsycho] [int] NULL,
	[Observation] [ntext] NULL,
 CONSTRAINT [PK_Colis] PRIMARY KEY CLUSTERED 
(
	[CleColis] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[Colis] ADD  CONSTRAINT [DF_Colis_NbColis]  DEFAULT ((0)) FOR [NbColis]
ALTER TABLE [dbo].[Colis] ADD  CONSTRAINT [DF_Colis_NbFrigo]  DEFAULT ((0)) FOR [NbFrigo]
ALTER TABLE [dbo].[Colis] ADD  CONSTRAINT [DF_Colis_NbPsycho]  DEFAULT ((0)) FOR [NbPsycho]
 end
GO
if not exists (select * from sysobjects where name='UpOperation' and xtype='U')
 begin
CREATE TABLE [dbo].[UpOperation](
	[CleOperation] [int] IDENTITY(1,1) NOT NULL,
	[CleUser] [int] NULL,
	[Periode] [datetime] NULL,
	[CleRubrique] [int] NULL,
	[Code] [nvarchar](50) NULL,
	[Rubrique] [nvarchar](250) NULL,
	[Base] [float] NULL,
	[Taux] [float] NULL,
	[Montant] [money] NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_UpOperation] PRIMARY KEY CLUSTERED 
(
	[CleOperation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[UpOperation] ADD  DEFAULT (getdate()) FOR [CreateDate]
 end
GO
if not exists (select * from sysobjects where name='UpPresence' and xtype='U')
 begin
CREATE TABLE [dbo].[UpPresence](
	[ClePresence] [int] IDENTITY(1,1) NOT NULL,
	[CleUser] [int] NULL,
	[Periode] [datetime] NULL,
	[Base] [float] NULL,
	[CreateDate] [datetime] NULL,
	
 CONSTRAINT [PK_UpPresence] PRIMARY KEY CLUSTERED 
(
	[ClePresence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[UpPresence] ADD  DEFAULT (getdate()) FOR [CreateDate]
 end
GO
if not exists (select * from sysobjects where name='DetailEffet3' and xtype='U')
 begin
CREATE TABLE [dbo].[DetailEffet3](
	[CleDetailEffet3] [int] IDENTITY(1,1) NOT NULL,
	[CleDetailEffet] [int] NULL,
	[CleEffet] [int] NULL,
	[CleLot] [int] NULL,
	[Quantite] [float] NULL,
	[RemisePourcent] [float] NULL,
	[ChargeValue] [money] NULL,
	[DateRemise] [datetime] NULL,
	[MontHT] [money] NULL,
	[NetHT] [money] NULL,
	[CreateDate] [datetime] NULL,	
 CONSTRAINT [aaaaaDetailEffet3_PK] PRIMARY KEY NONCLUSTERED 
(
	[CleDetailEffet3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ALTER TABLE [dbo].[DetailEffet3] ADD  CONSTRAINT [DF_DetailEffet3_Quantite]  DEFAULT ((0)) FOR [Quantite]
ALTER TABLE [dbo].[DetailEffet3] ADD  CONSTRAINT [DF_DetailEffet3_RemisePourcent]  DEFAULT ((0)) FOR [RemisePourcent]
ALTER TABLE [dbo].[DetailEffet3] ADD  CONSTRAINT [DF_DetailEffet3_ChargeValue]  DEFAULT ((0)) FOR [ChargeValue]
ALTER TABLE [dbo].[DetailEffet3] ADD  CONSTRAINT [DF_DetailEffet3_MontHT]  DEFAULT ((0)) FOR [MontHT]
ALTER TABLE [dbo].[DetailEffet3] ADD  CONSTRAINT [DF_DetailEffet3_NetHT]  DEFAULT ((0)) FOR [NetHT]
ALTER TABLE [dbo].[DetailEffet3] ADD  CONSTRAINT [DF_DetailEffet3_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
ALTER TABLE [dbo].[DetailEffet3] ADD  CONSTRAINT [DF_DetailEffet3_DateRemise]  DEFAULT (getdate()) FOR [DateRemise]

 end
GO
if not exists (select * from sysobjects where name='Prime' and xtype='U')
 begin
CREATE TABLE [dbo].[Prime](
	[ClePrime] [int] IDENTITY(1,1) NOT NULL,
	[Reference] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[CleUser] [int] NULL,
	[Debut1] [datetime] NULL,
	[Fin1] [datetime] NULL,
	[Debut2] [datetime] NULL,
	[Fin2] [datetime] NULL,
	[Note] [nvarchar](max) NULL,
	[Cloture] [bit] NULL,
	[CleUserCreate] [int] NULL,
	[CleUserModified] [int] NULL,
	[CreateDate] [datetime] NULL,
	[LastModifiedDate] [datetime] NULL,
	[Realisation] [money] NULL,
	[Marge] [money] NULL,
	[MargePourcent] [float] NULL,
	[Payement] [money] NULL,
	[PayementPourcent] [float] NULL,
	[Payement2] [money] NULL,
	[PayementPourcent2] [float] NULL,
	[Prime] [money] NULL,
 CONSTRAINT [PK_Prime] PRIMARY KEY CLUSTERED 
(
	[ClePrime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [dbo].[Prime] ADD  CONSTRAINT [DF_Prime_Cloture]  DEFAULT ((0)) FOR [Cloture]
ALTER TABLE [dbo].[Prime] ADD  CONSTRAINT [DF_Prime_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
ALTER TABLE [dbo].[Prime] ADD  CONSTRAINT [DF_Prime_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
ALTER TABLE [dbo].[Prime] ADD  CONSTRAINT [DF_Prime_Realisation]  DEFAULT ((0)) FOR [Realisation]
ALTER TABLE [dbo].[Prime] ADD  CONSTRAINT [DF_Prime_Marge]  DEFAULT ((0)) FOR [Marge]
ALTER TABLE [dbo].[Prime] ADD  CONSTRAINT [DF_Prime_MargePourcent]  DEFAULT ((0)) FOR [MargePourcent]
ALTER TABLE [dbo].[Prime] ADD  CONSTRAINT [DF_Prime_Payement]  DEFAULT ((0)) FOR [Payement]
ALTER TABLE [dbo].[Prime] ADD  CONSTRAINT [DF_Prime_PayementPourcent]  DEFAULT ((0)) FOR [PayementPourcent]
ALTER TABLE [dbo].[Prime] ADD  CONSTRAINT [DF_Prime_Payement2]  DEFAULT ((0)) FOR [Payement2]
ALTER TABLE [dbo].[Prime] ADD  CONSTRAINT [DF_Prime_PayementPourcent2]  DEFAULT ((0)) FOR [PayementPourcent2]
ALTER TABLE [dbo].[Prime] ADD  CONSTRAINT [DF_Prime_Prime]  DEFAULT ((0)) FOR [Prime]
 end
GO
if not exists (select * from sysobjects where name='PrimeCA' and xtype='U')
 begin
CREATE TABLE [dbo].[PrimeCA](
	[ClePrimeCA] [int] IDENTITY(1,1) NOT NULL,
	[ClePrime] [int] NULL,
	[Palier] [nvarchar](50) NULL,
	[Montant] [money] NULL,
	[Taux] [float] NULL,
 CONSTRAINT [PK_PrimeCA] PRIMARY KEY CLUSTERED 
(
	[ClePrimeCA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[PrimeCA] ADD  CONSTRAINT [DF_Prime_Montant]  DEFAULT ((0)) FOR [Montant]
ALTER TABLE [dbo].[PrimeCA] ADD  CONSTRAINT [DF_Prime_Taux]  DEFAULT ((0)) FOR [Taux]
 end
GO
if not exists (select * from sysobjects where name='PrimeMarge' and xtype='U')
 begin
CREATE TABLE [dbo].[PrimeMarge](
	[ClePrimeMarge] [int] IDENTITY(1,1) NOT NULL,
	[ClePrime] [int] NULL,
	[Palier] [nvarchar](50) NULL,
	[Ratio] [float] NULL,
	[Taux] [float] NULL,
 CONSTRAINT [PK_PrimeMarge] PRIMARY KEY CLUSTERED 
(
	[ClePrimeMarge] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[PrimeMarge] ADD  CONSTRAINT [DF_Prime_Ratio]  DEFAULT ((0)) FOR [Ratio]
ALTER TABLE [dbo].[PrimeMarge] ADD  CONSTRAINT [DF_PrimeMarge_Taux]  DEFAULT ((0)) FOR [Taux]
 end
GO
if not exists (select * from sysobjects where name='PrimeRecouvrement' and xtype='U')
 begin
CREATE TABLE [dbo].[PrimeRecouvrement](
	[ClePrimeRecouvrement] [int] IDENTITY(1,1) NOT NULL,
	[ClePrime] [int] NULL,
	[Palier] [nvarchar](50) NULL,
	[Ratio] [float] NULL,
	[Taux] [float] NULL,
 CONSTRAINT [PK_PrimeRecouvrement] PRIMARY KEY CLUSTERED 
(
	[ClePrimeRecouvrement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[PrimeRecouvrement] ADD  CONSTRAINT [DF_PrimeRecouvrement_Ratio]  DEFAULT ((0)) FOR [Ratio]
ALTER TABLE [dbo].[PrimeRecouvrement] ADD  CONSTRAINT [DF_PrimeRecouvrement_Taux]  DEFAULT ((0)) FOR [Taux]
 end
GO
/***********************************************************************************************************************************/
/*******************************************************column**********************************************************************/

if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Backupl' and COLUMN_NAME='TDEThumbprint')
begin
ALTER TABLE Backupl
  ADD TDEThumbprint varchar(10)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Backupl' and COLUMN_NAME='SnapshotUrl')
begin
ALTER TABLE Backupl
  ADD SnapshotUrl nvarchar(128)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='CRM' and COLUMN_NAME='Observation')
begin
alter table CRM add Observation nvarchar(255)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='CRM' and COLUMN_NAME='Agent')
begin
alter table CRM add Agent nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='CRMCommand' and COLUMN_NAME='Observation')
begin
alter table CRMCommand add Observation nvarchar(255)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='CRMCommand' and COLUMN_NAME='Quantite')
begin
alter table CRMCommand add Quantite float DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Convention' and COLUMN_NAME='Payement')
begin
ALTER TABLE Convention
  ADD Payement Money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Convention' and COLUMN_NAME='bVente')
begin
ALTER TABLE Convention
  ADD bVente bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Convention' and COLUMN_NAME='PrixAppliquer')
begin
ALTER TABLE Convention
  ADD PrixAppliquer int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Convention' and COLUMN_NAME='SupplementProduit')
begin
ALTER TABLE Convention
  ADD SupplementProduit money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Convention' and COLUMN_NAME='SupplementGamme')
begin
ALTER TABLE Convention
  ADD SupplementGamme money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Convention' and COLUMN_NAME='SupplementPhasing')
begin
ALTER TABLE Convention
  ADD SupplementPhasing money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Convention' and COLUMN_NAME='Ecart')
begin
ALTER TABLE Convention
  ADD Ecart money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Convention' and COLUMN_NAME='RealisationPalier')
begin
ALTER TABLE Convention
  ADD RealisationPalier money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Convention' and COLUMN_NAME='bHT')
begin
ALTER TABLE Convention
  ADD bHT bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailAvoir' and COLUMN_NAME='bUG')
begin
ALTER TABLE DetailAvoir
  ADD bUG bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailAvoir' and COLUMN_NAME='bRemise')
begin
ALTER TABLE DetailAvoir
  ADD bRemise bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailAvoir' and COLUMN_NAME='bRemise2')
begin
ALTER TABLE DetailAvoir
  ADD bRemise2 bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailAvoir' and COLUMN_NAME='TrancheUG')
begin
ALTER TABLE DetailAvoir
  ADD TrancheUG money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailAvoir' and COLUMN_NAME='TrancheRemise')
begin
ALTER TABLE DetailAvoir
  ADD TrancheRemise money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailAvoir' and COLUMN_NAME='TrancheRemise2')
begin
ALTER TABLE DetailAvoir
  ADD TrancheRemise2 money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailAvoir' and COLUMN_NAME='CleConvention')
begin
ALTER TABLE DetailAvoir
  ADD CleConvention int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailAvoir' and COLUMN_NAME='bAvfTaux')
begin
ALTER TABLE DetailAvoir
  ADD bAvfTaux bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailOpComptoir' and COLUMN_NAME='Duree')
begin
ALTER TABLE DetailOpComptoir
  ADD Duree int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEffet' and COLUMN_NAME='Cagnote')
begin
ALTER TABLE DetailEffet
  ADD Cagnote money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEffet' and COLUMN_NAME='PrixCagnote')
begin
ALTER TABLE DetailEffet
  ADD PrixCagnote money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEffet' and COLUMN_NAME='UG')
begin
ALTER TABLE DetailEffet
  ADD UG int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEffet' and COLUMN_NAME='Remise')
begin
ALTER TABLE DetailEffet
  ADD Remise money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEffet' and COLUMN_NAME='CleNatureTask')
begin
ALTER TABLE DetailEffet
  ADD CleNatureTask int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEffet' and COLUMN_NAME='CleEtatTask')
begin
ALTER TABLE DetailEffet
  ADD CleEtatTask int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEffet' and COLUMN_NAME='CleUser')
begin
ALTER TABLE DetailEffet
  ADD CleUser int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEffet' and COLUMN_NAME='Coeff')
begin
ALTER TABLE DetailEffet
  ADD Coeff float DEFAULT(-1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEffet' and COLUMN_NAME='CleUserCreate')
begin
ALTER TABLE DetailEffet
  ADD CleUserCreate int DEFAULT(-1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEffet' and COLUMN_NAME='CleUserModify')
begin
ALTER TABLE DetailEffet
  ADD CleUserModify int DEFAULT(-1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEffetCharge' and COLUMN_NAME='CleTypeCharge')
begin
ALTER TABLE DetailEffetCharge
  ADD CleTypeCharge int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailInventaire' and COLUMN_NAME='Comptage')
begin
ALTER TABLE DetailInventaire
  ADD Comptage int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailInventaire' and COLUMN_NAME='CleUser')
begin
ALTER TABLE DetailInventaire
  ADD CleUser int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailInventaire' and COLUMN_NAME='Invisible')
begin
ALTER TABLE DetailInventaire
  ADD Invisible bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailInventaire' and COLUMN_NAME='bAnomalie')
begin
ALTER TABLE DetailInventaire
  ADD bAnomalie bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailInventaire' and COLUMN_NAME='QteAnalyse')
begin
ALTER TABLE DetailInventaire
  ADD QteAnalyse float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailInventaire' and COLUMN_NAME='Observation')
begin
ALTER TABLE DetailInventaire
  ADD Observation nvarchar(200)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailTrans' and COLUMN_NAME='CleEffetCharge')
begin
ALTER TABLE DetailTrans
  ADD CleEffetCharge int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailTrans' and COLUMN_NAME='bRemise2')
begin
ALTER TABLE DetailTrans
  ADD bRemise2 bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='CategorieCharge' and COLUMN_NAME='bUseJournal')
begin
ALTER TABLE CategorieCharge
  ADD bUseJournal bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='CleTVA')
begin
ALTER TABLE Effet
  ADD CleTVA int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='bCagnote')
begin
ALTER TABLE Effet
  ADD bCagnote bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='bCagnote')
begin
ALTER TABLE Effet
  ADD bCagnote bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='bPsycho')
begin
ALTER TABLE Effet
  ADD bPsycho bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='bControle')
begin
ALTER TABLE Effet
  ADD bControle bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='MontantCagnote')
begin
ALTER TABLE Effet
  ADD MontantCagnote money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='PayementCagnote')
begin
ALTER TABLE Effet
  ADD PayementCagnote money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='RemiseCagnote')
begin
ALTER TABLE Effet
  ADD RemiseCagnote float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='RemisePourcent2')
begin
ALTER TABLE Effet
  ADD RemisePourcent2 float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='Remise2')
begin
ALTER TABLE Effet
  ADD Remise2 money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='Remise3')
begin
ALTER TABLE Effet
  ADD Remise3 money DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='bRemise')
begin
ALTER TABLE Effet
  ADD bRemise bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='bRemise2')
begin
ALTER TABLE Effet
  ADD bRemise2 bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='Invisible')
begin
ALTER TABLE Effet
  ADD Invisible bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='MontantBrute')
begin
ALTER TABLE Effet
  ADD MontantBrute money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='Avancement')
begin
ALTER TABLE Effet
  ADD Avancement int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='ClePreparateur')
begin
ALTER TABLE Effet
  ADD ClePreparateur int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='CleControleur')
begin
ALTER TABLE Effet
  ADD CleControleur int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='CleEffetCharge')
begin
ALTER TABLE Effet
  ADD CleEffetCharge int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='PayementRemise')
begin
ALTER TABLE Effet
  ADD PayementRemise money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='PayementRemise2')
begin
ALTER TABLE Effet
  ADD PayementRemise2 money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='CleExpediteur')
begin
ALTER TABLE Effet
  ADD CleExpediteur int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='PayementAssocie')
begin
ALTER TABLE Effet
  ADD PayementAssocie nvarchar(MAX)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='DateImpression')
begin
ALTER TABLE Effet
  ADD DateImpression datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='CleUserCreate')
begin
ALTER TABLE Effet
  ADD CleUserCreate int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='RemiseApp')
begin
ALTER TABLE Effet
  ADD RemiseApp money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='RemiseAvf')
begin
ALTER TABLE Effet
  ADD RemiseAvf money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='PayementRemiseAvf')
begin
ALTER TABLE Effet
  ADD PayementRemiseAvf money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='CagnoteConsome')
begin
ALTER TABLE Effet
  ADD CagnoteConsome money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='bUsePrimeCA')
begin
ALTER TABLE Effet
  ADD bUsePrimeCA bit DEFAULT(1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='bUsePrimePayement')
begin
ALTER TABLE Effet
  ADD bUsePrimePayement bit DEFAULT(1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Effet' and COLUMN_NAME='CleUserPayement')
begin
ALTER TABLE Effet
  ADD CleUserPayement int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EffetCharge' and COLUMN_NAME='CleTVA')
begin
ALTER TABLE EffetCharge
  ADD CleTVA int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EffetCharge' and COLUMN_NAME='CleEntreprise')
begin
ALTER TABLE EffetCharge
  ADD CleEntreprise int DEFAULT(1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EffetCharge' and COLUMN_NAME='Invisible')
begin
ALTER TABLE EffetCharge
  ADD Invisible bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EffetCharge' and COLUMN_NAME='CleCategorieCharge')
begin
ALTER TABLE EffetCharge
  ADD CleCategorieCharge int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EffetCharge' and COLUMN_NAME='CleEtatEffetCharge')
begin
ALTER TABLE EffetCharge
  ADD CleEtatEffetCharge int DEFAULT(1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EffetCharge' and COLUMN_NAME='PayementAssocie')
begin
ALTER TABLE EffetCharge
  ADD PayementAssocie nvarchar(MAX)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EffetCharge' and COLUMN_NAME='bUseTauxRemise')
begin
ALTER TABLE EffetCharge
  ADD bUseTauxRemise bit DEFAULT(1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EffetCharge' and COLUMN_NAME='bUseJournal')
begin
ALTER TABLE EffetCharge
  ADD bUseJournal bit DEFAULT(1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EffetCharge' and COLUMN_NAME='CleEffet')
begin
ALTER TABLE EffetCharge
  ADD CleEffet int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EffetCharge' and COLUMN_NAME='bUsePrimeCA')
begin
ALTER TABLE EffetCharge
  ADD bUsePrimeCA bit DEFAULT(1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EffetCharge' and COLUMN_NAME='bUsePrimePayement')
begin
ALTER TABLE EffetCharge
  ADD bUsePrimePayement bit DEFAULT(1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EtatOpComptoir' and COLUMN_NAME='bInstance')
begin
ALTER TABLE EtatOpComptoir
  ADD bInstance bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EtatOpComptoir' and COLUMN_NAME='bAdmin')
begin
ALTER TABLE EtatOpComptoir
  ADD bAdmin bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='FamilleArticle' and COLUMN_NAME='bMedicament')
begin
ALTER TABLE FamilleArticle
  ADD bMedicament bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='FamilleArticle' and COLUMN_NAME='Next')
begin
ALTER TABLE FamilleArticle
  ADD Next int DEFAULT(1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='TypeCharge' and COLUMN_NAME='bAuxilliaire')
begin
ALTER TABLE TypeCharge
  ADD bAuxilliaire bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Inventaire' and COLUMN_NAME='CleEntreprise')
begin
ALTER TABLE Inventaire
  ADD CleEntreprise int DEFAULT(1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Investissement' and COLUMN_NAME='CleEcriture')
begin
ALTER TABLE Investissement
  ADD CleEcriture int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='HistQuota' and COLUMN_NAME='CleUser')
begin
ALTER TABLE HistQuota
  ADD CleUser int 
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='HistQuota' and COLUMN_NAME='CleUser2')
begin
ALTER TABLE HistQuota
  ADD CleUser2 int 
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='Remise')
begin
ALTER TABLE Lot
  ADD Remise float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='Invisible')
begin
ALTER TABLE Lot
  ADD Invisible bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='Remise2')
begin
ALTER TABLE Lot
  ADD Remise2 float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='QteGarde')
begin
ALTER TABLE Lot
  ADD QteGarde float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE Lot
  ADD CreateDate datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='LastModifiedDate')
begin
ALTER TABLE Lot
  ADD LastModifiedDate datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='Remise3')
begin
ALTER TABLE Lot
  ADD Remise3 float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='MaxUG3')
begin
ALTER TABLE Lot
  ADD MaxUG3 float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='CleUser')
begin
ALTER TABLE Lot
  ADD CleUser int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='CleUserModify')
begin
ALTER TABLE Lot
  ADD CleUserModify int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='Note')
begin
ALTER TABLE Lot
  ADD Note nvarchar(MAX)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='CleUserBloque')
begin
ALTER TABLE Lot
  ADD CleUserBloque int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='LastBloqueDate')
begin
ALTER TABLE Lot
  ADD LastBloqueDate datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='AutoBloque')
begin
ALTER TABLE Lot
  ADD AutoBloque bit
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='bNonQuota')
begin
ALTER TABLE Lot
  ADD bNonQuota bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Lot' and COLUMN_NAME='bNonDestockage')
begin
ALTER TABLE Lot
  ADD bNonDestockage bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='StockDepot' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE StockDepot
  ADD CreateDate datetime DEFAULT(getdate())
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='PrixVente' and COLUMN_NAME='CleLot')
begin
ALTER TABLE PrixVente
  ADD CleLot int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='CleDCI')
begin
ALTER TABLE Produit
  ADD CleDCI int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='ClePresentation')
begin
ALTER TABLE Produit
  ADD ClePresentation int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='Dosage')
begin
ALTER TABLE Produit
  ADD Dosage nvarchar(100)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='N_ENREGISTREMENT')
begin
ALTER TABLE Produit
  ADD N_ENREGISTREMENT char(5)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='Invisible')
begin
ALTER TABLE Produit
  ADD Invisible bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='CleLabo')
begin
ALTER TABLE Produit
  ADD CleLabo int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='CleUserModify')
begin
ALTER TABLE Produit
  ADD CleUserModify int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='bPrinceps')
begin
ALTER TABLE Produit
  ADD bPrinceps bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='bRembourssable')
begin
ALTER TABLE Produit
  ADD bRembourssable bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='QteMaxCmd')
begin
ALTER TABLE Produit
  ADD QteMaxCmd float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='bfrigo')
begin
ALTER TABLE Produit
  ADD bfrigo bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='CleClasse')
begin
ALTER TABLE Produit
  ADD CleClasse int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='TypeQuota')
begin
ALTER TABLE Produit
  ADD TypeQuota int DEFAULT(1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='bDestockage')
begin
ALTER TABLE Produit
  ADD bDestockage bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='TypeDestockage')
begin
ALTER TABLE Produit
  ADD TypeDestockage int DEFAULT(1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='bJour')
begin
ALTER TABLE Produit
  ADD bJour bit DEFAULT(1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='DebutMax')
begin
ALTER TABLE Produit
  ADD DebutMax datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='FinMax')
begin
ALTER TABLE Produit
  ADD FinMax datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='bClientControle')
begin
ALTER TABLE Produit
  ADD bClientControle bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Produit' and COLUMN_NAME='bControle')
begin
ALTER TABLE Produit
  ADD bControle bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DCI' and COLUMN_NAME='Code')
begin
ALTER TABLE DCI
  ADD Code nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='QuotaAvance' and COLUMN_NAME='bDestockage')
begin
ALTER TABLE QuotaAvance
  ADD bDestockage bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='QuotaAvance' and COLUMN_NAME='DateLimite')
begin
ALTER TABLE QuotaAvance
  ADD DateLimite datetime DEFAULT (getdate()) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Quota' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE Quota
  ADD CreateDate datetime DEFAULT (getdate()) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Quota2' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE Quota2
  ADD CreateDate datetime DEFAULT (getdate()) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='QuotaAvance' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE QuotaAvance
  ADD CreateDate datetime DEFAULT (getdate()) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EffetQuota' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE EffetQuota
  ADD CreateDate datetime DEFAULT (getdate()) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='QuotaAvanceHist' and COLUMN_NAME='bDestockage')
begin
ALTER TABLE QuotaAvanceHist
  ADD bDestockage bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Production' and COLUMN_NAME='CleUser')
begin
ALTER TABLE Production
  ADD CleUser int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Liste' and COLUMN_NAME='Couleur')
begin
ALTER TABLE Liste
  ADD Couleur int DEFAULT(1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Liste' and COLUMN_NAME='Note')
begin
ALTER TABLE Liste
  ADD Note nvarchar(MAX)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='CleVendeur')
begin
ALTER TABLE Tiers
  ADD CleVendeur int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='bPoint')
begin
ALTER TABLE Tiers
  ADD bPoint bit
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='Point')
begin
ALTER TABLE Tiers
  ADD Point int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='bPrixVente')
begin
ALTER TABLE Tiers
  ADD bPrixVente bit
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='Invisible')
begin
ALTER TABLE Tiers
  ADD Invisible int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='CleMode')
begin
ALTER TABLE Tiers
  ADD CleMode int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='Ratio')
begin
ALTER TABLE Tiers
  ADD Ratio int DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='Ratio2')
begin
ALTER TABLE Tiers
  ADD Ratio2 float DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='Ratio3')
begin
ALTER TABLE Tiers
  ADD Ratio3 float DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='UseUGAchat')
begin
ALTER TABLE Tiers
  ADD UseUGAchat bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='UseUGMax')
begin
ALTER TABLE Tiers
  ADD UseUGMax bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='bRemiseAchat')
begin
ALTER TABLE Tiers
  ADD bRemiseAchat bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='beneficieRemiseAchat')
begin
ALTER TABLE Tiers
  ADD beneficieRemiseAchat bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='bEcheance')
begin
ALTER TABLE Tiers
  ADD bEcheance bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='CleCompte')
begin
ALTER TABLE Tiers
  ADD CleCompte int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='CleCommercial')
begin
ALTER TABLE Tiers
  ADD CleCommercial int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='CleUser2')
begin
ALTER TABLE Tiers
  ADD CleUser2 int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='CleStatutTiers')
begin
ALTER TABLE Tiers
  ADD CleStatutTiers int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='Viber')
begin
ALTER TABLE Tiers
  ADD Viber nvarchar(255)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='Autre')
begin
ALTER TABLE Tiers
  ADD Autre nvarchar(255)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='BP')
begin
ALTER TABLE Tiers
  ADD BP nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='bRemiseTaux')
begin
ALTER TABLE Tiers
  ADD bRemiseTaux bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='bImpAvf')
begin
ALTER TABLE Tiers
  ADD bImpAvf bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='bAvfConsome')
begin
ALTER TABLE Tiers
  ADD bAvfConsome bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='SoldeCagnote')
begin
ALTER TABLE Tiers
  ADD SoldeCagnote money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='SoldeCagnote2')
begin
ALTER TABLE Tiers
  ADD SoldeCagnote2 money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='CleForm')
begin
ALTER TABLE Tiers
  ADD CleForm int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='Disponibilite')
begin
ALTER TABLE Tiers
  ADD Disponibilite nvarchar(255)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='CleUser3')
begin
ALTER TABLE Tiers
  ADD CleUser3 int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='Transfered3')
begin
ALTER TABLE Tiers
  ADD Transfered3 bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='CleUserActuel')
begin
ALTER TABLE Tiers
  ADD CleUserActuel int DEFAULT(-1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='CleUserCreate')
begin
ALTER TABLE Tiers
  ADD CleUserCreate int DEFAULT(1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='CleUserModify')
begin
ALTER TABLE Tiers
  ADD CleUserModify int DEFAULT(1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Tiers' and COLUMN_NAME='bSynchPsy')
begin
ALTER TABLE Tiers
  ADD bSynchPsy bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Transact' and COLUMN_NAME='CleEffet')
begin
ALTER TABLE Transact
  ADD CleEffet int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Transact' and COLUMN_NAME='Label')
begin
ALTER TABLE Transact
  ADD Label nvarchar(MAX)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Transact' and COLUMN_NAME='Note')
begin
ALTER TABLE Transact
  ADD Note nvarchar(MAX)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Transact' and COLUMN_NAME='bExplorer')
begin
ALTER TABLE Transact
  ADD bExplorer bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Transact' and COLUMN_NAME='Invisible')
begin
ALTER TABLE Transact
  ADD Invisible bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Transact' and COLUMN_NAME='RemisePourcent')
begin
ALTER TABLE Transact
  ADD RemisePourcent float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Transact' and COLUMN_NAME='DateRemise')
begin
ALTER TABLE Transact
  ADD DateRemise datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Transact' and COLUMN_NAME='RemisePourcent2')
begin
ALTER TABLE Transact
  ADD RemisePourcent2 float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='User' and COLUMN_NAME='bCommercial')
begin
ALTER TABLE [User]
  ADD bCommercial bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='User' and COLUMN_NAME='bVendeur')
begin
ALTER TABLE [User]
  ADD bVendeur bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='User' and COLUMN_NAME='bPreparateur')
begin
ALTER TABLE [User]
  ADD bPreparateur bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='User' and COLUMN_NAME='bControleur')
begin
ALTER TABLE [User]
  ADD bControleur bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='User' and COLUMN_NAME='bOperateur')
begin
ALTER TABLE [User]
  ADD bOperateur bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='User' and COLUMN_NAME='bExpediteur')
begin
ALTER TABLE [User]
  ADD bExpediteur bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='User' and COLUMN_NAME='Invisible')
begin
ALTER TABLE [User]
  ADD Invisible bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='User' and COLUMN_NAME='Ratio')
begin
ALTER TABLE [User]
  ADD Ratio float DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Prenom')
begin
ALTER TABLE [UserInfo]
  ADD Prenom nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='NomJFille')
begin
ALTER TABLE [UserInfo]
  ADD NomJFille nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Prenom2')
begin
ALTER TABLE [UserInfo]
  ADD Prenom2 nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Initial')
begin
ALTER TABLE [UserInfo]
  ADD Initial nvarchar(5)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Adresse')
begin
ALTER TABLE [UserInfo]
  ADD Adresse nvarchar(200)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Ville')
begin
ALTER TABLE [UserInfo]
  ADD Ville nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='CleWilaya')
begin
ALTER TABLE [UserInfo]
  ADD CleWilaya int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='CodePostal')
begin
ALTER TABLE [UserInfo]
  ADD CodePostal nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='DateNaissance')
begin
ALTER TABLE [UserInfo]
  ADD DateNaissance datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='LieuNaissance')
begin
ALTER TABLE [UserInfo]
  ADD LieuNaissance nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Tel')
begin
ALTER TABLE [UserInfo]
  ADD Tel nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Mobile')
begin
ALTER TABLE [UserInfo]
  ADD Mobile nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Email')
begin
ALTER TABLE [UserInfo]
  ADD Email nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Nationalite')
begin
ALTER TABLE [UserInfo]
  ADD Nationalite nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Sexe')
begin
ALTER TABLE [UserInfo]
  ADD Sexe int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Photo')
begin
ALTER TABLE [UserInfo]
  ADD Photo image
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Note')
begin
ALTER TABLE [UserInfo]
  ADD Note ntext
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='CleDirection')
begin
ALTER TABLE [UserInfo]
  ADD CleDirection int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='CleFonction')
begin
ALTER TABLE [UserInfo]
  ADD CleFonction int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='CleEtatCivil')
begin
ALTER TABLE [UserInfo]
  ADD CleEtatCivil int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Nenfant')
begin
ALTER TABLE [UserInfo]
  ADD Nenfant int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='PersCharge')
begin
ALTER TABLE [UserInfo]
  ADD PersCharge int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='CleTypeSalaire')
begin
ALTER TABLE [UserInfo]
  ADD CleTypeSalaire int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='SalaireBase')
begin
ALTER TABLE [UserInfo]
  ADD SalaireBase money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='NSecuriteSociale')
begin
ALTER TABLE [UserInfo]
  ADD NSecuriteSociale nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='TauxPatronale')
begin
ALTER TABLE [UserInfo]
  ADD TauxPatronale float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Mutuelle')
begin
ALTER TABLE [UserInfo]
  ADD Mutuelle nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='CleTypeContrat')
begin
ALTER TABLE [UserInfo]
  ADD CleTypeContrat int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='DateRecrutement')
begin
ALTER TABLE [UserInfo]
  ADD DateRecrutement datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='DateFinContrat')
begin
ALTER TABLE [UserInfo]
  ADD DateFinContrat datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='ClePosition')
begin
ALTER TABLE [UserInfo]
  ADD ClePosition int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Observation')
begin
ALTER TABLE [UserInfo]
  ADD Observation ntext
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='DateDepart')
begin
ALTER TABLE [UserInfo]
  ADD DateDepart datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='CleMotifDepart')
begin
ALTER TABLE [UserInfo]
  ADD CleMotifDepart int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='CleMode')
begin
ALTER TABLE [UserInfo]
  ADD CleMode int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='CleAgence')
begin
ALTER TABLE [UserInfo]
  ADD CleAgence int DEFAULT(-1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Compte')
begin
ALTER TABLE [UserInfo]
  ADD Compte nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Conge')
begin
ALTER TABLE [UserInfo]
  ADD Conge float DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='CleServiceNational')
begin
ALTER TABLE [UserInfo]
  ADD CleServiceNational int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bPlein')
begin
ALTER TABLE [UserInfo]
  ADD bPlein bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bPartiel')
begin
ALTER TABLE [UserInfo]
  ADD bPartiel bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bRotation')
begin
ALTER TABLE [UserInfo]
  ADD bRotation bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bSaisonnier')
begin
ALTER TABLE [UserInfo]
  ADD bSaisonnier bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='NiveauEtude')
begin
ALTER TABLE [UserInfo]
  ADD NiveauEtude nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Diplome')
begin
ALTER TABLE [UserInfo]
  ADD Diplome nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='DebutEtude')
begin
ALTER TABLE [UserInfo]
  ADD DebutEtude datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='FinEtude')
begin
ALTER TABLE [UserInfo]
  ADD FinEtude datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='AutreDiplome')
begin
ALTER TABLE [UserInfo]
  ADD AutreDiplome nvarchar(250)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Lecture')
begin
ALTER TABLE [UserInfo]
  ADD Lecture int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Redaction')
begin
ALTER TABLE [UserInfo]
  ADD Redaction int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Communication')
begin
ALTER TABLE [UserInfo]
  ADD Communication int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Calcul')
begin
ALTER TABLE [UserInfo]
  ADD Calcul int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bArabe')
begin
ALTER TABLE [UserInfo]
  ADD bArabe bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bFrancais')
begin
ALTER TABLE [UserInfo]
  ADD bFrancais bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bAnglais')
begin
ALTER TABLE [UserInfo]
  ADD bAnglais bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='AutreLangue')
begin
ALTER TABLE [UserInfo]
  ADD AutreLangue nvarchar(250)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bWord')
begin
ALTER TABLE [UserInfo]
  ADD bWord bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bExcel')
begin
ALTER TABLE [UserInfo]
  ADD bExcel bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bOutlook')
begin
ALTER TABLE [UserInfo]
  ADD bOutlook bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='AutreOffice')
begin
ALTER TABLE [UserInfo]
  ADD AutreOffice nvarchar(250)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Employeur1')
begin
ALTER TABLE [UserInfo]
  ADD Employeur1 nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Fonction1')
begin
ALTER TABLE [UserInfo]
  ADD Fonction1 nvarchar(100)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Debut1')
begin
ALTER TABLE [UserInfo]
  ADD Debut1 datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Fin1')
begin
ALTER TABLE [UserInfo]
  ADD Fin1 datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Employeur2')
begin
ALTER TABLE [UserInfo]
  ADD Employeur2 nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Fonction2')
begin
ALTER TABLE [UserInfo]
  ADD Fonction2 nvarchar(100)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Debut2')
begin
ALTER TABLE [UserInfo]
  ADD Debut2 datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Fin2')
begin
ALTER TABLE [UserInfo]
  ADD Fin2 datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Employeur3')
begin
ALTER TABLE [UserInfo]
  ADD Employeur3 nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Fonction3')
begin
ALTER TABLE [UserInfo]
  ADD Fonction3 nvarchar(100)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Debut3')
begin
ALTER TABLE [UserInfo]
  ADD Debut3 datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Fin3')
begin
ALTER TABLE [UserInfo]
  ADD Fin3 datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Sante')
begin
ALTER TABLE [UserInfo]
  ADD Sante ntext
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='NomPere')
begin
ALTER TABLE [UserInfo]
  ADD NomPere nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='NomMere')
begin
ALTER TABLE [UserInfo]
  ADD NomMere nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Contact')
begin
ALTER TABLE [UserInfo]
  ADD Contact nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='AdresseContact')
begin
ALTER TABLE [UserInfo]
  ADD AdresseContact nvarchar(200)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='TelContact')
begin
ALTER TABLE [UserInfo]
  ADD TelContact nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='EmailContact')
begin
ALTER TABLE [UserInfo]
  ADD EmailContact nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='Fonction')
begin
ALTER TABLE [UserInfo]
  ADD Fonction nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bSamedi')
begin
ALTER TABLE [UserInfo]
  ADD bSamedi bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bDimanche')
begin
ALTER TABLE [UserInfo]
  ADD bDimanche bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bLundi')
begin
ALTER TABLE [UserInfo]
  ADD bLundi bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bMardi')
begin
ALTER TABLE [UserInfo]
  ADD bMardi bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bMercredi')
begin
ALTER TABLE [UserInfo]
  ADD bMercredi bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bJeudi')
begin
ALTER TABLE [UserInfo]
  ADD bJeudi bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bVendredi')
begin
ALTER TABLE [UserInfo]
  ADD bVendredi bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserInfo' and COLUMN_NAME='bPointage')
begin
ALTER TABLE [UserInfo]
  ADD bPointage bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserIdentification' and COLUMN_NAME='Poste')
begin
ALTER TABLE UserIdentification
  ADD Poste nvarchar(100) 
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UserIdentification' and COLUMN_NAME='Session')
begin
ALTER TABLE UserIdentification
  ADD Session nvarchar(100) 
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Objectif' and COLUMN_NAME='Recouvrement')
begin
ALTER TABLE Objectif
  ADD Recouvrement money DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='OpComptoir' and COLUMN_NAME='Payement')
begin
ALTER TABLE OpComptoir
  ADD Payement money DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailExpedition' and COLUMN_NAME='NbFrigo')
begin
ALTER TABLE DetailExpedition
  ADD NbFrigo int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailExpedition' and COLUMN_NAME='NbPsycho')
begin
ALTER TABLE DetailExpedition
  ADD NbPsycho int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Compte' and COLUMN_NAME='bLocked')
begin
ALTER TABLE Compte
  ADD bLocked bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Compte' and COLUMN_NAME='Invisible')
begin
ALTER TABLE Compte
  ADD Invisible bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='ConventionPalier' and COLUMN_NAME='Palier')
begin
ALTER TABLE ConventionPalier
  ADD Palier nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='ConventionDetailPalier' and COLUMN_NAME='Debut')
begin
ALTER TABLE ConventionDetailPalier
  ADD Debut datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='ConventionDetailPalier' and COLUMN_NAME='Fin')
begin
ALTER TABLE ConventionDetailPalier
  ADD Fin datetime
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='ConventionDetailPalier' and COLUMN_NAME='Gamme')
begin
ALTER TABLE ConventionDetailPalier
  ADD Gamme nvarchar(50)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EtatTransaction' and COLUMN_NAME='bDette')
begin
ALTER TABLE EtatTransaction
  ADD bDette bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Solvabilite' and COLUMN_NAME='Couleur')
begin
ALTER TABLE Solvabilite
  ADD Couleur int DEFAULT(1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Prime' and COLUMN_NAME='CleEntreprise')
begin
ALTER TABLE Prime
  ADD CleEntreprise int DEFAULT(1) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpDocument' and COLUMN_NAME='Invisible')
begin
ALTER TABLE UpDocument
  ADD Invisible bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpPaye' and COLUMN_NAME='Invisible')
begin
ALTER TABLE UpPaye
  ADD Invisible bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailRatioTiers' and COLUMN_NAME='RCagnote')
begin
ALTER TABLE DetailRatioTiers
  ADD RCagnote float
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailRatioTiers' and COLUMN_NAME='Cagnote')
begin
ALTER TABLE DetailRatioTiers
  ADD Cagnote Money
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Ecriture' and COLUMN_NAME='Jour')
begin
ALTER TABLE Ecriture
  ADD jour int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Ecriture' and COLUMN_NAME='CleJour')
begin
ALTER TABLE Ecriture
  ADD Clejour int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpPoint' and COLUMN_NAME='CleEntreprise')
begin
ALTER TABLE UpPoint
  ADD CleEntreprise int DEFAULT(1)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpPaye' and COLUMN_NAME='CleFonction')
begin
ALTER TABLE UpPaye
  ADD CleFonction int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpPaye' and COLUMN_NAME='CleDirection')
begin
ALTER TABLE UpPaye
  ADD CleDirection int
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpRubrique' and COLUMN_NAME='bIRGPourcent')
begin
ALTER TABLE UpRubrique
  ADD bIRGPourcent bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpRubrique' and COLUMN_NAME='CalculAbs')
begin
ALTER TABLE UpRubrique
  ADD CalculAbs bit DEFAULT(0) with values
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpRubrique' and COLUMN_NAME='CalculHS')
begin
ALTER TABLE UpRubrique
  ADD CalculHS bit DEFAULT(0) with values
end
go
ALTER TABLE uppointage alter column bentree int
GO
/**************************************************colonne create date*************************************************************/
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailAvoir' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DetailAvoir
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update detailAvoir set CreateDate=(select CreateDate from EffetCharge where CleEffetCharge=DetailAvoir.CleEffetCharge) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEcriture' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DetailEcriture
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update detailEcriture set CreateDate=(select CreateDate from Ecriture where CleEcriture=DetailEcriture.CleEcriture) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailEffetGroup' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DetailEffetGroup
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update detailEffetGroup set CreateDate=(select DateCreated from EffetGroup where CleEffetGroup=DetailEffetGroup.CleEffetGroup) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailExpedition' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DetailExpedition
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update detailExpedition set CreateDate=(select DateCreation from Expedition where CleExpedition=DetailExpedition.CleExpedition) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailInventaire' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DetailInventaire
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update detailInventaire set CreateDate=(select [Date] from Inventaire where CleInventaire=DetailInventaire.CleInventaire) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailOpComptoir' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DetailOpComptoir
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update detailOpComptoir set CreateDate=(select Heure from OpComptoir where CleOpComptoir=DetailOpComptoir.CleOpComptoir) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailProduction' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DetailProduction
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update detailProduction set CreateDate=(select [Date] from Production where CleProduction=DetailProduction.CleProduction) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailRatioTiers' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DetailRatioTiers
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update DetailRatioTiers set CreateDate=getdate() where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DetailTrans' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DetailTrans
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update detailTrans set CreateDate=(select CreateDate from Transact where CleTransact=DetailTrans.CleTransaction) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DocEffet' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DocEffet
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update DocEffet set CreateDate=(select CreateDate from Effet where CleEffet=DocEffet.CleEffet) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DocEffetCharge' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DocEffetCharge
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update DocEffetCharge set CreateDate=(select CreateDate from EffetCharge where CleEffetCharge=DocEffetCharge.CleEffetCharge) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DocExpedition' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DocExpedition
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update DocExpedition set CreateDate=(select DateCreation from Expedition where CleExpedition=DocExpedition.CleExpedition) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DocProduction' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DocProduction
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update DocProduction set CreateDate=(select [Date] from Production where CleProduction=DocProduction.CleProduction) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='DocTransaction' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE DocTransaction
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update DocTransaction set CreateDate=(select CreateDate from Transact where CleTransact=DocTransaction.CleTransaction) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Inventaire' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE Inventaire
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update Inventaire set CreateDate=[Date] where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Objectif' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE Objectif
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update Objectif set CreateDate=getdate() where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='OpComptoir' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE OpComptoir
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update OpComptoir set CreateDate=Heure where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Production' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE Production
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update Production set CreateDate=[Date] where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='ProductionDetail' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE ProductionDetail
  ADD CreateDate datetime DEFAULT(getdate())
end
go
update ProductionDetail set CreateDate=(select [Date] from Production where CleProduction=ProductionDetail.CleProduction) where createdate is null
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpAppointment' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE UpAppointment
  ADD CreateDate datetime DEFAULT(getdate())
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpDetailPaye' and COLUMN_NAME='CreateDate')
begin
ALTER TABLE UpDetailPaye
  ADD CreateDate datetime DEFAULT(getdate())
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpPaye' and COLUMN_NAME='MontantCongeConsomme')
begin
ALTER TABLE UpPaye
  ADD MontantCongeConsomme money DEFAULT(0)
end
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpPaye' and COLUMN_NAME='bSpecial')
begin
ALTER TABLE UpPaye
  ADD bSpecial bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpPaye' and COLUMN_NAME='Cloture')
begin
ALTER TABLE UpPaye
  ADD Cloture bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpOperation' and COLUMN_NAME='bLiaison')
begin
ALTER TABLE UpOperation
  ADD bLiaison bit DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='UpOperation' and COLUMN_NAME='ClePaye')
begin
ALTER TABLE UpOperation
  ADD ClePaye int DEFAULT(0)
end
go
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='EtatTask' and COLUMN_NAME='bFautif')
begin
ALTER TABLE EtatTask
  ADD bFautif bit DEFAULT(0)
end
go
update UpDetailPaye set CreateDate=(select DateCreation from UpPaye where ClePaye=UpDetailPaye.ClePaye) where createdate is null
go
/********************************************update nouvel colonne*****************************************************************/
update Convention set Payement=0 where Payement is null
go
update Convention set bVente=0 where bVente is null
go
update Convention set PrixAppliquer=0 where PrixAppliquer is null
go
update Convention set SupplementProduit=0 where SupplementProduit is null
go
update Convention set SupplementGamme=0 where SupplementGamme is null
go
update Convention set SupplementPhasing=0 where SupplementPhasing is null
go
update Convention set Ecart=0 where Ecart is null
go
update Convention set RealisationPalier=0 where RealisationPalier is null
go
update Convention set bHT=0 where bHT is null
go
update detailAvoir set bUG=0 where bUG is null
go
update detailAvoir set bRemise=0 where bRemise is null
go
update detailAvoir set bRemise2=0 where bRemise2 is null
go
update detailAvoir set TrancheUG=0 where TrancheUG is null
go
update detailAvoir set TrancheRemise=0 where TrancheRemise is null
go
update detailAvoir set TrancheRemise2=0 where TrancheRemise2 is null
go
update detailAvoir set bAvfTaux=0 where bAvfTaux is null
go
update detailOpComptoir set Duree=0 where Duree is null
go
update detaileffet set Cagnote=0 where Cagnote is null
go
update detaileffet set UG=0 where UG is null
go
update detaileffet set Remise=0 where Remise is null
go
update detailInventaire set Comptage=0 where Comptage is null
go
update detailInventaire set Invisible=0 where Invisible is null
go
update detailInventaire set bAnomalie=0 where bAnomalie is null
go
update detailInventaire set QteAnalyse=0 where QteAnalyse is null
go
update detailTrans set CleEffetCharge=0 where CleEffetCharge is null
go
update effet set bCagnote=0 where bCagnote is null
go
update effet set MontantCagnote=0 where MontantCagnote is null
go
update effet set PayementCagnote=0 where PayementCagnote is null
go
update effet set RemiseCagnote=0 where RemiseCagnote is null
go
update effet set RemisePourcent2=0 where RemisePourcent2 is null
go
update effet set Remise2=0 where Remise2 is null
go
update effet set bRemise=0 where bRemise is null
go
update effet set bRemise2=0 where bRemise2 is null
go
update effet set Invisible=0 where Invisible is null
go
update effet set MontantBrute=0 where MontantBrute is null
go
update effet set Avancement=0 where Avancement is null
go
update effet set bPsycho=0 where bPsycho is null
go
update effet set bControle=0 where bControle is null
go
update effet set CleTransaction=-1 where CleTransaction is null
go
update effet set PayementRemise=0 where PayementRemise is null
go
update effet set PayementRemise2=0 where PayementRemise2 is null
go
update effet set CleExpediteur=-1 where CleExpediteur is null
go
update effet set CleUserPayement=CleUser where CleUserPayement is null
go
update effetCharge set CleEntreprise=1 where CleEntreprise is null
go
update effetCharge set Invisible=0 where Invisible is null
go
update effetCharge set CleEtatEffetCharge=1 where CleEtatEffetCharge is null
go
update effetCharge set bUseTauxRemise=1 where bUseTauxRemise is null
go
update categorieCharge set bUseJournal=0 where bUseJournal is null
go
update EtatOpComptoir set bInstance=0 where bInstance is null
go
update EtatOpComptoir set bAdmin=0 where bAdmin is null
go
update FamilleArticle set bMedicament=0 where bMedicament is null
go
update FamilleArticle set Next=1 where Next is null
go
update Inventaire set CleEntreprise=1 where CleEntreprise is null
go
update Produit set CleClasse=-1 where CleClasse is null
go
update Lot set Remise=0 where Remise is null
go
update Lot set Invisible=0 where Invisible is null
go
update Lot set Remise2=0 where Remise2 is null
go
update Lot set QteGarde=0 where QteGarde is null
go
update Lot set Remise3=0 where Remise3 is null
go
update Lot set MaxUG3=0 where MaxUG3 is null
go
update Liste set Couleur=1 where Couleur is null
go
update PrixVente set CleLot=0 where CleLot is null
go
update Produit set Invisible=0 where Invisible is null
go
update Produit set DebutMax=getdate() where DebutMax is null
go
update Produit set FinMax=getdate() where FinMax is null
go
update Tiers set Invisible=0 where Invisible is null
go
update Tiers set Ratio=0 where Ratio is null
go
update Tiers set UseUGAchat=0 where UseUGAchat is null
go
update Tiers set UseUGMax=0 where UseUGMax is null
go
update Tiers set bRemiseTaux=0 where bRemiseTaux is null
go
update Tiers set bImpAvf=0 where bImpAvf is null
go
update Tiers set bAvfConsome=0 where bAvfConsome is null
go
update Tiers set bRemiseAchat=0 where bRemiseAchat is null
go
update Tiers set beneficieRemiseAchat=0 where beneficieRemiseAchat is null
go
update Tiers set bEcheance=0 where bEcheance is null
go
update Tiers set CleUser2=-1 where CleUser2 is null
go
update Tiers set CleUser3=-1 where CleUser3 is null
go
update Tiers set Transfered=0 where Transfered is null
go
update Tiers set Transfered3=0 where Transfered3 is null
go
update Tiers set CleStatutTiers=-1 where CleStatutTiers is null
go
update Tiers set CleSolvabilite=-1 where CleSolvabilite is null
go
update Tiers set SoldeCagnote=0 where SoldeCagnote is null
go
update Tiers set SoldeCagnote2=0 where SoldeCagnote2 is null
go
update Transact set bExplorer=0 where bExplorer is null
go
update Transact set Invisible=0 where Invisible is null
go
update Transact set RemisePourcent=0 where RemisePourcent is null
go
update Transact set RemisePourcent2=RemisePourcent where RemisePourcent2 is null
go
update OpComptoir set Payement=0 where Payement is null
go
update Parametre set Valeur=0 where CleParametre IN (240,241) and Valeur is null
go
update Parametre set Valeur=-1 where Valeur is null
go
update Parametre set Valeur3=0 where Valeur3 is null
go
update ParametreCpt set Valeur=-1 where Valeur is null
go
update ParametreCpt set Valeur3=0 where Valeur3 is null
go
update DetailExpedition set NbFrigo=0 where NbFrigo is null
go
update DetailExpedition set NbPsycho=0 where NbPsycho is null
go
update Compte set bLocked=0 where bLocked is null
go
update Compte set Invisible=0 where Invisible is null
go
update EtatTransaction set bDette=0 where bDette is null
go
update Solvabilite set Couleur=1 where Couleur is null
go
update [User] set bExpediteur=0 where bExpediteur is null
go
update [User] set Invisible=0 where Invisible is null
go
update [UserInfo] set bPointage=1 where bPointage is null
go
update [UpPaye] set Invisible=0 where Invisible is null
go
update [UpDocument] set Invisible=0 where Invisible is null
go
update DetailRatioTiers set RCagnote=0 where RCagnote is null
go
update DetailRatioTiers set Cagnote=0 where Cagnote is null
go
update UpPaye set MontantCongeConsomme=0 where MontantCongeConsomme is null
go
update UpPaye set bSpecial=0 where bSpecial is null
go
update UpPaye set Cloture=0 where Cloture is null
go
update EtatTask set bFautif=0 where bFautif is null
go
update Effet set CleUserCreate=CleUser where CleUserCreate is null
go
update Effet set RemiseApp=0 where RemiseApp is null
go
update Effet set RemiseAvf=0 where RemiseAvf is null
go
update Effet set PayementRemiseAvf=0 where PayementRemiseAvf is null
go
update Effet set CagnoteConsome=0 where CagnoteConsome is null
go
update Produit set bPrinceps=0 where bPrinceps is null
go
update Produit set bRembourssable=0 where bRembourssable is null
go
update Produit set bFrigo=0 where bFrigo is null
go
update Produit set QteMaxCmd=0 where QteMaxCmd is null
go
update d  set    d.bRemise2=cast((case when e.bRemise2=0 and t.RemisePourcent>0 then 1 else 0 end) as bit)
FROM          dbo.Effet as e INNER JOIN
                        dbo.DetailTrans as d ON e.CleEffet = d.CleEffet INNER JOIN
                        dbo.Transact as t ON d.CleTransaction = t.CleTransact
						where d.bRemise2 is null
go
update s set s.CreateDate=l.CreateDate from lot as l inner join StockDepot as s on l.CleLot=s.CleLot where s.CreateDate is null
go
update d set d.CleUserCreate= e.CleUserCreate FROM dbo.Effet as e INNER JOIN dbo.DetailEffet as d ON e.CleEffet = d.CleEffet where d.CleUserCreate = -1
go
/*************************************************************************************************************************************/

/******************************************************row****************************************************************************/
SET IDENTITY_INSERT [dbo].[Version] ON 
GO
If Not Exists(select * from Version where CleVersion=1)
Begin
insert into Version (CleVersion,Version) values (1,'22.11.30.1')
End
If Not Exists(select * from Version where CleVersion=2)
Begin
insert into Version (CleVersion,Version) values (2,'24.10.1.1')
End
If Not Exists(select * from Version where CleVersion=3)
Begin
insert into Version (CleVersion,Version) values (3,'24.10.2.1')
End
If Not Exists(select * from Version where CleVersion=4)
Begin
insert into Version (CleVersion,Version) values (4,'24.10.3.1')
End
If Not Exists(select * from Version where CleVersion=5)
Begin
insert into Version (CleVersion,Version) values (5,'24.10.4.1')
End
If Not Exists(select * from Version where CleVersion=6)
Begin
insert into Version (CleVersion,Version) values (6,'24.10.4.3')
End
If Not Exists(select * from Version where CleVersion=7)
Begin
insert into Version (CleVersion,Version) values (7,'24.10.4.4')
End
If Not Exists(select * from Version where CleVersion=8)
Begin
insert into Version (CleVersion,Version) values (8,'24.10.4.5')
End
GO
SET IDENTITY_INSERT [dbo].[Version] OFF 
GO

If Not Exists(select * from NextRef where CleNextRef=48)
Begin
insert into NextRef(NextSize,Next,Pattern) VALUES(4,1,'Pr')
End
If Not Exists(select * from Coefficient where CleCoefficient=1)
Begin
insert into Coefficient(Coefficient,Libelle,Couleur) VALUES(0,'Défaut',1)
End
If Not Exists(select * from parametre where CleParametre=162)
Begin
insert into parametre (Name,Valeur3) values ('1achatgroupeauto',1)
End
If Not Exists(select * from parametre where CleParametre=163)
Begin
insert into parametre (Name,Valeur3) values ('2expeditionauto',1)
End
If Not Exists(select * from parametre where CleParametre=164)
Begin
insert into parametre (Name,Valeur3) values ('2preparateur',0)
End
If Not Exists(select * from parametre where CleParametre=165)
Begin
insert into parametre (Name,Valeur3) values ('2controleur',0)
End
If Not Exists(select * from parametre where CleParametre=166)
Begin
insert into parametre (Name,Valeur3) values ('2demarcheur',0)
End
If Not Exists(select * from parametre where CleParametre=167)
Begin
insert into parametre (Name,Valeur3) values ('2commercial',0)
End
If Not Exists(select * from parametre where CleParametre=168)
Begin
insert into parametre (Name,Valeur3) values ('2locktrans',1)
End
If Not Exists(select * from parametre where CleParametre=169)
Begin
insert into parametre (Name,Valeur3) values ('21calculechance',1)
End
If Not Exists(select * from parametre where CleParametre=170)
Begin
insert into parametre (Name,Valeur3) values ('21calculauto',0)
End
If Not Exists(select * from parametre where CleParametre=171)
Begin
insert into parametre (Name,Valeur3) values ('21lastfact',1)
End
If Not Exists(select * from parametre where CleParametre=172)
Begin
insert into parametre (Name,Valeur3) values ('21lastday',0)
End
If Not Exists(select * from parametre where CleParametre=173)
Begin
insert into parametre (Name,Valeur) values ('21jour',30)
End
If Not Exists(select * from parametre where CleParametre=174)
Begin
insert into parametre (Name,Valeur2) values ('21datecalcul','01-09-2017')
End
If Not Exists(select * from parametre where CleParametre=175)
Begin
insert into parametre (Name,Valeur) values ('22typeug',1)
End
If Not Exists(select * from parametre where CleParametre=176)
Begin
insert into parametre (Name,Valeur2) values ('22libelleug','Remise accordée  1')
End
If Not Exists(select * from parametre where CleParametre=177)
Begin
insert into parametre (Name,Valeur) values ('22typeremise',1)
End
If Not Exists(select * from parametre where CleParametre=178)
Begin
insert into parametre (Name,Valeur2) values ('22libelleremise','Remise accordée  2')
End
If Not Exists(select * from parametre where CleParametre=179)
Begin
insert into parametre (Name,Valeur) values ('22typepay',1)
End
If Not Exists(select * from parametre where CleParametre=180)
Begin
insert into parametre (Name,Valeur2) values ('22libellepay','Remise accordée  3')
End
If Not Exists(select * from parametre where CleParametre=181)
Begin
insert into parametre (Name,Valeur) values ('22typeremise',1)
End
If Not Exists(select * from parametre where CleParametre=182)
Begin
insert into parametre (Name,Valeur2) values ('22libelleremise','Remise accordée 4')
End
If Not Exists(select * from parametre where CleParametre=183)
Begin
insert into parametre (Name,Valeur3) values ('23conventionauto',1)
End
If Not Exists(select * from parametre where CleParametre=184)
Begin
insert into parametre (Name,Valeur3) values ('4margeconv',0)
End
If Not Exists(select * from parametre where CleParametre=185)
Begin
insert into parametre (Name,Valeur3) values ('23conventionauto2',1)
End
If Not Exists(select * from parametre where CleParametre=186)
Begin
insert into parametre (Name,Valeur3) values ('9blpsy',1)
End
If Not Exists(select * from parametre where CleParametre=187)
Begin
insert into parametre (Name,Valeur3) values ('3ugpiece',0)
End
If Not Exists(select * from parametre where CleParametre=188)
Begin
insert into parametre (Name,Valeur3) values ('13cagnotte',0)
End
If Not Exists(select * from parametre where CleParametre=189)
Begin
insert into parametre (Name,Valeur3) values ('9prodequi',0)
End
If Not Exists(select * from parametre where CleParametre=190)
Begin
insert into parametre (Name,Valeur3) values ('13analyse',0)
End
If Not Exists(select * from parametre where CleParametre=191)
Begin
insert into parametre (Name,Valeur2) values ('13archiveheureprecise','12:00:00')
End
If Not Exists(select * from parametre where CleParametre=192)
Begin
insert into parametre (Name,Valeur) values ('3irentree',-1)
End
If Not Exists(select * from parametre where CleParametre=193)
Begin
insert into parametre (Name,Valeur) values ('3irsortie',-1)
End
If Not Exists(select * from parametre where CleParametre=194)
Begin
insert into parametre (Name,Valeur3) values ('4ouvertinvrapide',0)
End
If Not Exists(select * from parametre where CleParametre=195)
Begin
insert into parametre (Name,Valeur3) values ('3perissable',1)
End
If Not Exists(select * from parametre where CleParametre=196)
Begin
insert into parametre (Name,Valeur3) values ('4deblocageauto',1)
End
If Not Exists(select * from parametre where CleParametre=197)
Begin
insert into parametre (Name,Valeur3) values ('13norme',1)
End
If Not Exists(select * from parametre where CleParametre=198)
Begin
insert into parametre (Name,Valeur) values ('3tri',0)
End
If Not Exists(select * from parametre where CleParametre=199)
Begin
insert into parametre (Name,Valeur3) values ('2fp',0)
End
If Not Exists(select * from parametre where CleParametre=200)
Begin
insert into parametre (Name,Valeur3) values ('2cf',0)
End
If Not Exists(select * from parametre where CleParametre=201)
Begin
insert into parametre (Name,Valeur3) values ('2cc',0)
End
If Not Exists(select * from parametre where CleParametre=202)
Begin
insert into parametre (Name,Valeur3) values ('2fa',0)
End
If Not Exists(select * from parametre where CleParametre=203)
Begin
insert into parametre (Name,Valeur3) values ('2fv',0)
End
If Not Exists(select * from parametre where CleParametre=204)
Begin
insert into parametre (Name,Valeur3) values ('2aa',0)
End
If Not Exists(select * from parametre where CleParametre=205)
Begin
insert into parametre (Name,Valeur3) values ('2av',0)
End
If Not Exists(select * from parametre where CleParametre=206)
Begin
insert into parametre (Name,Valeur3) values ('2br',0)
End
If Not Exists(select * from parametre where CleParametre=207)
Begin
insert into parametre (Name,Valeur3) values ('2bl',0)
End
If Not Exists(select * from parametre where CleParametre=208)
Begin
insert into parametre (Name,Valeur3) values ('2rf',0)
End
If Not Exists(select * from parametre where CleParametre=209)
Begin
insert into parametre (Name,Valeur3) values ('2rc',0)
End
If Not Exists(select * from parametre where CleParametre=210)
Begin
insert into parametre (Name,Valeur3) values ('2be',0)
End
If Not Exists(select * from parametre where CleParametre=211)
Begin
insert into parametre (Name,Valeur3) values ('2bs',0)
End
If Not Exists(select * from parametre where CleParametre=212)
Begin
insert into parametre (Name,Valeur3) values ('2brenvoi',0)
End
If Not Exists(select * from parametre where CleParametre=213)
Begin
insert into parametre (Name,Valeur3) values ('2binteg',0)
End
If Not Exists(select * from parametre where CleParametre=214)
Begin
insert into parametre (Name,Valeur3) values ('2ca',0)
End
If Not Exists(select * from parametre where CleParametre=215)
Begin
insert into parametre (Name,Valeur3) values ('2cv',0)
End
If Not Exists(select * from parametre where CleParametre=216)
Begin
insert into parametre (Name,Valeur3) values ('2bt',0)
End
If Not Exists(select * from parametre where CleParametre=217)
Begin
insert into parametre (Name,Valeur3) values ('2recfr',0)
End
If Not Exists(select * from parametre where CleParametre=218)
Begin
insert into parametre (Name,Valeur3) values ('2reccl',0)
End
If Not Exists(select * from parametre where CleParametre=219)
Begin
insert into parametre (Name,Valeur3) values ('6pieceinstance',0)
End
If Not Exists(select * from parametre where CleParametre=220)
Begin
insert into parametre (Name,Valeur3) values ('6pieceverr',0)
End
If Not Exists(select * from parametre where CleParametre=221)
Begin
insert into parametre (Name,Valeur3) values ('18cagnote',0)
End
If Not Exists(select * from parametre where CleParametre=222)
Begin
insert into parametre (Name,Valeur) values ('18coefcagnote',1)
End
If Not Exists(select * from parametre where CleParametre=223)
Begin
insert into parametre (Name,Valeur2) values ('18debutcagnote','')
End
If Not Exists(select * from parametre where CleParametre=224)
Begin
insert into parametre (Name,Valeur2) values ('18fincagnote','')
End
If Not Exists(select * from parametre where CleParametre=225)
Begin
insert into parametre (Name,Valeur3) values ('5precision',1)
End
If Not Exists(select * from parametre where CleParametre=226)
Begin
insert into parametre (Name,Valeur) values ('7tiersnactif',90)
End
If Not Exists(select * from parametre where CleParametre=227)
Begin
insert into parametre (Name,Valeur3) values ('2TransfVerr',0)
End
If Not Exists(select * from parametre where CleParametre=228)
Begin
insert into parametre (Name,Valeur3) values ('9remisemax',0)
End
If Not Exists(select * from parametre where CleParametre=229)
Begin
insert into parametre (Name,Valeur) values ('9tauxmax',10)
End
If Not Exists(select * from parametre where CleParametre=230)
Begin
insert into parametre (Name,Valeur3) values ('9bcagnotte',0)
End
If Not Exists(select * from parametre where CleParametre=231)
Begin
insert into parametre (Name,Valeur3) values ('9bremise',0)
End
If Not Exists(select * from parametre where CleParametre=232)
Begin
insert into parametre (Name,Valeur3) values ('9bremise2',0)
End
If Not Exists(select * from parametre where CleParametre=233)
Begin
insert into parametre (Name,Valeur3) values ('9createbon',0)
End
If Not Exists(select * from parametre where CleParametre=234)
Begin
insert into parametre (Name,Valeur3) values ('8bmin',0)
End
If Not Exists(select * from parametre where CleParametre=235)
Begin
insert into parametre (Name,Valeur3) values ('8bmax',0)
End
If Not Exists(select * from parametre where CleParametre=236)
Begin
insert into parametre (Name,Valeur2) values ('8montantmin',0)
End
If Not Exists(select * from parametre where CleParametre=237)
Begin
insert into parametre (Name,Valeur2) values ('8montantmax',0)
End
If Not Exists(select * from parametre where CleParametre=238)
Begin
insert into parametre (Name,Valeur) values ('22categoriecharge',1)
End
If Not Exists(select * from parametre where CleParametre=239)
Begin
insert into parametre (Name,Valeur3) values ('9blfrigo',0)
End
If Not Exists(select * from parametre where CleParametre=240)
Begin
insert into parametre (Name,Valeur) values ('4coef.courant',0)
End
If Not Exists(select * from parametre where CleParametre=241)
Begin
insert into parametre (Name,Valeur) values ('4coef.quota',0)
End
If Not Exists(select * from parametre where CleParametre=242)
Begin
insert into parametre (Name,Valeur3) values ('4lotdefautcmd',0)
End
If Not Exists(select * from parametre where CleParametre=243)
Begin
insert into parametre (Name,Valeur) values ('4lotcmd',0)
End
If Not Exists(select * from parametre where CleParametre=244)
Begin
insert into parametre (Name,Valeur3) values ('24actualiser',0)
End
If Not Exists(select * from parametre where CleParametre=245)
Begin
insert into parametre (Name,Valeur3) values ('24bloqueobs',0)
End
If Not Exists(select * from parametre where CleParametre=246)
Begin
insert into parametre (Name,Valeur3) values ('24exigerqtt',0)
End
If Not Exists(select * from parametre where CleParametre=247)
Begin
insert into parametre (Name,Valeur) values ('12etatdebut1',1)
End
If Not Exists(select * from parametre where CleParametre=248)
Begin
insert into parametre (Name,Valeur) values ('12etatfin1',2)
End
If Not Exists(select * from parametre where CleParametre=249)
Begin
insert into parametre (Name,Valeur) values ('12etatdebut2',2)
End
If Not Exists(select * from parametre where CleParametre=250)
Begin
insert into parametre (Name,Valeur) values ('12etatfin2',3)
End
If Not Exists(select * from parametre where CleParametre=251)
Begin
insert into parametre (Name,Valeur) values ('12etatdebut3',3)
End
If Not Exists(select * from parametre where CleParametre=252)
Begin
insert into parametre (Name,Valeur) values ('12etatfin3',4)
End
If Not Exists(select * from parametre where CleParametre=253)
Begin
insert into parametre (Name,Valeur) values ('12etatdebut4',4)
End
If Not Exists(select * from parametre where CleParametre=254)
Begin
insert into parametre (Name,Valeur) values ('12etatfin4',5)
End
If Not Exists(select * from parametre where CleParametre=255)
Begin
insert into parametre (Name,Valeur3) values ('4statutqte',0)
End
If Not Exists(select * from parametre where CleParametre=256)
Begin
insert into parametre (Name,Valeur) values ('4coef.destockage',4)
End
If Not Exists(select * from parametre where CleParametre=257)
Begin
insert into parametre (Name,Valeur3) values ('18messagequota',0)
End
If Not Exists(select * from parametre where CleParametre=258)
Begin
insert into parametre (Name,Valeur) values ('18etatdebut5',3)
End
If Not Exists(select * from parametre where CleParametre=259)
Begin
insert into parametre (Name,Valeur) values ('18etatfin5',4)
End
If Not Exists(select * from parametre where CleParametre=260)
Begin
insert into parametre (Name,Valeur3) values ('4messageug',0)
End
If Not Exists(select * from parametre where CleParametre=261)
Begin
insert into parametre (Name,Valeur2) values ('11MinCA','0')
End
If Not Exists(select * from parametre where CleParametre=262)
Begin
insert into parametre (Name,Valeur2) values ('11MinPay','0')
End
If Not Exists(select * from parametre where CleParametre=263)
Begin
insert into parametre (Name,Valeur) values ('11Ech',0)
End
If Not Exists(select * from parametre where CleParametre=264)
Begin
insert into parametre (Name,Valeur3) values ('11refautoprime',1)
End
If Not Exists(select * from parametre where CleParametre=265)
Begin
insert into parametre (Name,Valeur) values ('11recouvrement',0)
End

If Not Exists(select * from parametreCpt where CleParametre=57)
Begin
insert into parametreCpt (Name,Valeur2) values ('6server','127.0.0.1')
End
If Not Exists(select * from parametreCpt where CleParametre=58)
Begin
insert into parametreCpt (Name,Valeur2) values ('6bdd','D:\Chifa_Officine\OFFICINE.GDB')
End
If Not Exists(select * from parametreCpt where CleParametre=59)
Begin
insert into parametreCpt (Name,Valeur2) values ('4imprimante','Canon 3010')
End
If Not Exists(select * from parametreCpt where CleParametre=60)
Begin
insert into parametreCpt (Name,Valeur2) values ('4fontentreprise','Arial Narrow; 8.25pt; style=Italic, Underline')
End
If Not Exists(select * from parametreCpt where CleParametre=61)
Begin
insert into parametreCpt (Name,Valeur2) values ('4fontproduit','Arial Narrow; 8.25pt; style=Italic, Underline')
End
If Not Exists(select * from parametreCpt where CleParametre=62)
Begin
insert into parametreCpt (Name,Valeur2) values ('4fontprix','Arial Narrow; 8.25pt; style=Italic, Underline')
End
If Not Exists(select * from parametreCpt where CleParametre=63)
Begin
insert into parametreCpt (Name,Valeur2) values ('4fontexp','Arial Narrow; 8.25pt; style=Italic, Underline')
End
If Not Exists(select * from parametreCpt where CleParametre=64)
Begin
insert into parametreCpt (Name,Valeur2) values ('4fontlot','Arial Narrow; 8.25pt; style=Italic, Underline')
End
If Not Exists(select * from parametreCpt where CleParametre=65)
Begin
insert into parametreCpt (Name,Valeur) values ('4codebarre',3)
End
If Not Exists(select * from parametreCpt where CleParametre=66)
Begin
insert into parametreCpt (Name,Valeur) values ('6mode',2)
End
If Not Exists(select * from parametreCpt where CleParametre=67)
Begin
insert into parametreCpt (Name,Valeur) values ('4produitinit',1)
End
If Not Exists(select * from parametreCpt where CleParametre=68)
Begin
insert into parametreCpt (Name,Valeur) values ('4produitsize',6)
End
If Not Exists(select * from parametreCpt where CleParametre=69)
Begin
insert into parametreCpt (Name,Valeur) values ('4qttinit',7)
End
If Not Exists(select * from parametreCpt where CleParametre=70)
Begin
insert into parametreCpt (Name,Valeur) values ('4qttsize',4)
End
If Not Exists(select * from parametreCpt where CleParametre=71)
Begin
insert into parametreCpt (Name,Valeur) values ('4codesize',12)
End
If Not Exists(select * from parametreCpt where CleParametre=72)
Begin
insert into parametreCpt (Name,Valeur3) values ('4marque',0)
End
If Not Exists(select * from parametreCpt where CleParametre=73)
Begin
insert into parametreCpt (Name,Valeur2) values ('4fontmarque','Arial Narrow; 8.25pt; style=Italic, Underline')
End

If Not Exists(select * from Profile where CleProfile=260)
Begin
insert into profile (Profile) values ('1rec')
End
If Not Exists(select * from Profile where CleProfile=261)
Begin
insert into profile (Profile) values ('1jrec')
End
If Not Exists(select * from Profile where CleProfile=262)
Begin
insert into profile (Profile) values ('2rec')
End
If Not Exists(select * from Profile where CleProfile=263)
Begin
insert into profile (Profile) values ('2jrec')
End
If Not Exists(select * from Profile where CleProfile=264)
Begin
insert into profile (Profile) values ('7modrecfr')
End
If Not Exists(select * from Profile where CleProfile=265)
Begin
insert into profile (Profile) values ('7modreccl')
End
If Not Exists(select * from Profile where CleProfile=266)
Begin
insert into profile (Profile) values ('7supprecfr')
End
If Not Exists(select * from Profile where CleProfile=267)
Begin
insert into profile (Profile) values ('7suppreccl')
End
If Not Exists(select * from Profile where CleProfile=268)
Begin
insert into profile (Profile) values ('5tiers')
End
If Not Exists(select * from Profile where CleProfile=269)
Begin
insert into profile (Profile) values ('5tiersaj')
End
If Not Exists(select * from Profile where CleProfile=270)
Begin
insert into profile (Profile) values ('5tiersmod')
End
If Not Exists(select * from Profile where CleProfile=271)
Begin
insert into profile (Profile) values ('5tierssupp')
End
If Not Exists(select * from Profile where CleProfile=272)
Begin
insert into profile (Profile) values ('etatpiece')
End
If Not Exists(select * from Profile where CleProfile=273)
Begin
insert into profile (Profile) values ('auroimpression')
End
If Not Exists(select * from Profile where CleProfile=274)
Begin
insert into profile (Profile) values ('cagnote')
End
If Not Exists(select * from Profile where CleProfile=275)
Begin
insert into profile (Profile) values ('7user')
End
If Not Exists(select * from Profile where CleProfile=276)
Begin
insert into profile (Profile) values ('7cagnote')
End
If Not Exists(select * from Profile where CleProfile=277)
Begin
insert into profile (Profile) values ('10exploitation')
End
If Not Exists(select * from Profile where CleProfile=278)
Begin
insert into profile (Profile) values ('10charge')
End
If Not Exists(select * from Profile where CleProfile=279)
Begin
insert into profile (Profile) values ('10produit')
End
If Not Exists(select * from Profile where CleProfile=280)
Begin
insert into profile (Profile) values ('10journal c/p')
End
If Not Exists(select * from Profile where CleProfile=281)
Begin
insert into profile (Profile) values ('7modcharge')
End
If Not Exists(select * from Profile where CleProfile=282)
Begin
insert into profile (Profile) values ('7modproduit')
End
If Not Exists(select * from Profile where CleProfile=283)
Begin
insert into profile (Profile) values ('7suppcharge')
End
If Not Exists(select * from Profile where CleProfile=284)
Begin
insert into profile (Profile) values ('7suppproduit')
End
If Not Exists(select * from Profile where CleProfile=285)
Begin
insert into profile (Profile) values ('5credit')
End
If Not Exists(select * from Profile where CleProfile=286)
Begin
insert into profile (Profile) values ('5debit')
End
If Not Exists(select * from Profile where CleProfile=287)
Begin
insert into profile (Profile) values ('9typecharge')
End
If Not Exists(select * from Profile where CleProfile=288)
Begin
insert into profile (Profile) values ('8limitertiers')
End
If Not Exists(select * from Profile where CleProfile=289)
Begin
insert into profile (Profile) values ('1fournisseurcacher')
End
If Not Exists(select * from Profile where CleProfile=290)
Begin
insert into profile (Profile) values ('1fournisseurafficher')
End
If Not Exists(select * from Profile where CleProfile=291)
Begin
insert into profile (Profile) values ('2clientcacher')
End
If Not Exists(select * from Profile where CleProfile=292)
Begin
insert into profile (Profile) values ('2clientafficher')
End
If Not Exists(select * from Profile where CleProfile=293)
Begin
insert into profile (Profile) values ('10tierscacher')
End
If Not Exists(select * from Profile where CleProfile=294)
Begin
insert into profile (Profile) values ('10tiersafficher')
End
If Not Exists(select * from Profile where CleProfile=295)
Begin
insert into profile (Profile) values ('3produitcacher')
End
If Not Exists(select * from Profile where CleProfile=296)
Begin
insert into profile (Profile) values ('3produitafficher')
End
If Not Exists(select * from Profile where CleProfile=297)
Begin
insert into profile (Profile) values ('3lotcacher')
End
If Not Exists(select * from Profile where CleProfile=298)
Begin
insert into profile (Profile) values ('3lotafficher')
End
If Not Exists(select * from Profile where CleProfile=299)
Begin
insert into profile (Profile) values ('7piececacher')
End
If Not Exists(select * from Profile where CleProfile=300)
Begin
insert into profile (Profile) values ('7pieceafficher')
End
If Not Exists(select * from Profile where CleProfile=301)
Begin
insert into profile (Profile) values ('5transcacher')
End
If Not Exists(select * from Profile where CleProfile=302)
Begin
insert into profile (Profile) values ('5transafficher')
End
If Not Exists(select * from Profile where CleProfile=303)
Begin
insert into profile (Profile) values ('7modtransformation')
End
If Not Exists(select * from Profile where CleProfile=304)
Begin
insert into profile (Profile) values ('1achatgroupeaj')
End
If Not Exists(select * from Profile where CleProfile=305)
Begin
insert into profile (Profile) values ('1achatgroupemod')
End
If Not Exists(select * from Profile where CleProfile=306)
Begin
insert into profile (Profile) values ('1achatgroupesupp')
End
If Not Exists(select * from Profile where CleProfile=307)
Begin
insert into profile (Profile) values ('1achatgroupeverr')
End
If Not Exists(select * from Profile where CleProfile=308)
Begin
insert into profile (Profile) values ('1produitaj')
End
If Not Exists(select * from Profile where CleProfile=309)
Begin
insert into profile (Profile) values ('1produitsupp')
End
If Not Exists(select * from Profile where CleProfile=310)
Begin
insert into profile (Profile) values ('3listing')
End
If Not Exists(select * from Profile where CleProfile=311)
Begin
insert into profile (Profile) values ('3listingaj')
End
If Not Exists(select * from Profile where CleProfile=312)
Begin
insert into profile (Profile) values ('3listingsupp')
End
If Not Exists(select * from Profile where CleProfile=313)
Begin
insert into profile (Profile) values ('3listingquota')
End
If Not Exists(select * from Profile where CleProfile=314)
Begin
insert into profile (Profile) values ('6creancecl')
End
If Not Exists(select * from Profile where CleProfile=315)
Begin
insert into profile (Profile) values ('6creancefr')
End
If Not Exists(select * from Profile where CleProfile=316)
Begin
insert into profile (Profile) values ('6etatmarge')
End
If Not Exists(select * from Profile where CleProfile=317)
Begin
insert into profile (Profile) values ('3recalculecagnote')
End
If Not Exists(select * from Profile where CleProfile=318)
Begin
insert into profile (Profile) values ('6suiviachat')
End
If Not Exists(select * from Profile where CleProfile=319)
Begin
insert into profile (Profile) values ('6suivivente')
End
If Not Exists(select * from Profile where CleProfile=320)
Begin
insert into profile (Profile) values ('7document')
End
If Not Exists(select * from Profile where CleProfile=321)
Begin
insert into profile (Profile) values ('1listing')
End
If Not Exists(select * from Profile where CleProfile=322)
Begin
insert into profile (Profile) values ('6classementclient')
End
If Not Exists(select * from Profile where CleProfile=323)
Begin
insert into profile (Profile) values ('7etatreclamation')
End
If Not Exists(select * from Profile where CleProfile=324)
Begin
insert into profile (Profile) values ('7fautif')
End
If Not Exists(select * from Profile where CleProfile=325)
Begin
insert into profile (Profile) values ('expedition')
End
If Not Exists(select * from Profile where CleProfile=326)
Begin
insert into profile (Profile) values ('journalexpedition')
End
If Not Exists(select * from Profile where CleProfile=327)
Begin
insert into profile (Profile) values ('expeditionmod')
End
If Not Exists(select * from Profile where CleProfile=328)
Begin
insert into profile (Profile) values ('expeditionsupp')
End
If Not Exists(select * from Profile where CleProfile=329)
Begin
insert into profile (Profile) values ('expeditionverr')
End
If Not Exists(select * from Profile where CleProfile=330)
Begin
insert into profile (Profile) values ('expeditionimp')
End
If Not Exists(select * from Profile where CleProfile=331)
Begin
insert into profile (Profile) values ('7preparateur')
End
If Not Exists(select * from Profile where CleProfile=332)
Begin
insert into profile (Profile) values ('7controleur')
End
If Not Exists(select * from Profile where CleProfile=333)
Begin
insert into profile (Profile) values ('7commercial')
End
If Not Exists(select * from Profile where CleProfile=334)
Begin
insert into profile (Profile) values ('7demarcheur')
End
If Not Exists(select * from Profile where CleProfile=335)
Begin
insert into profile (Profile) values ('7doctransact')
End
If Not Exists(select * from Profile where CleProfile=336)
Begin
insert into profile (Profile) values ('7doctransactajout')
End
If Not Exists(select * from Profile where CleProfile=337)
Begin
insert into profile (Profile) values ('7doctransactmod')
End
If Not Exists(select * from Profile where CleProfile=338)
Begin
insert into profile (Profile) values ('7doctransactsupp')
End
If Not Exists(select * from Profile where CleProfile=339)
Begin
insert into profile (Profile) values ('7doceffet')
End
If Not Exists(select * from Profile where CleProfile=340)
Begin
insert into profile (Profile) values ('7doceffetajout')
End
If Not Exists(select * from Profile where CleProfile=341)
Begin
insert into profile (Profile) values ('7doceffetmod')
End
If Not Exists(select * from Profile where CleProfile=342)
Begin
insert into profile (Profile) values ('7doceffetsupp')
End
If Not Exists(select * from Profile where CleProfile=343)
Begin
insert into profile (Profile) values ('7doceffetcharge')
End
If Not Exists(select * from Profile where CleProfile=344)
Begin
insert into profile (Profile) values ('7doceffetchargeajout')
End
If Not Exists(select * from Profile where CleProfile=345)
Begin
insert into profile (Profile) values ('7doceffetchargemod')
End
If Not Exists(select * from Profile where CleProfile=346)
Begin
insert into profile (Profile) values ('7doceffetchargesupp')
End
If Not Exists(select * from Profile where CleProfile=347)
Begin
insert into profile (Profile) values ('7doctiers')
End
If Not Exists(select * from Profile where CleProfile=348)
Begin
insert into profile (Profile) values ('7doctiersajout')
End
If Not Exists(select * from Profile where CleProfile=349)
Begin
insert into profile (Profile) values ('7doctiersmod')
End
If Not Exists(select * from Profile where CleProfile=350)
Begin
insert into profile (Profile) values ('7doctierssupp')
End
If Not Exists(select * from Profile where CleProfile=351)
Begin
insert into profile (Profile) values ('7docproduit')
End
If Not Exists(select * from Profile where CleProfile=352)
Begin
insert into profile (Profile) values ('7docproduitajout')
End
If Not Exists(select * from Profile where CleProfile=353)
Begin
insert into profile (Profile) values ('7docproduitmod')
End
If Not Exists(select * from Profile where CleProfile=354)
Begin
insert into profile (Profile) values ('7docproduitsupp')
End
If Not Exists(select * from Profile where CleProfile=355)
Begin
insert into profile (Profile) values ('7docproduction')
End
If Not Exists(select * from Profile where CleProfile=356)
Begin
insert into profile (Profile) values ('7docproductionajout')
End
If Not Exists(select * from Profile where CleProfile=357)
Begin
insert into profile (Profile) values ('7docproductionmod')
End
If Not Exists(select * from Profile where CleProfile=358)
Begin
insert into profile (Profile) values ('7docproductionsupp')
End
If Not Exists(select * from Profile where CleProfile=359)
Begin
insert into profile (Profile) values ('7docexpedition')
End
If Not Exists(select * from Profile where CleProfile=360)
Begin
insert into profile (Profile) values ('7docexpeditionajout')
End
If Not Exists(select * from Profile where CleProfile=361)
Begin
insert into profile (Profile) values ('7docexpeditionmod')
End
If Not Exists(select * from Profile where CleProfile=362)
Begin
insert into profile (Profile) values ('7docexpeditionsupp')
End
If Not Exists(select * from Profile where CleProfile=363)
Begin
insert into profile (Profile) values ('Objectif')
End
If Not Exists(select * from Profile where CleProfile=364)
Begin
insert into profile (Profile) values ('2objectifmod')
End
If Not Exists(select * from Profile where CleProfile=365)
Begin
insert into profile (Profile) values ('9categoriecharge')
End
If Not Exists(select * from Profile where CleProfile=366)
Begin
insert into profile (Profile) values ('4affecterqte')
End
If Not Exists(select * from Profile where CleProfile=367)
Begin
insert into profile (Profile) values ('4affecteruser')
End
If Not Exists(select * from Profile where CleProfile=368)
Begin
insert into profile (Profile) values ('4ajoutercomptage')
End
If Not Exists(select * from Profile where CleProfile=369)
Begin
insert into profile (Profile) values ('4suppcomptage')
End
If Not Exists(select * from Profile where CleProfile=370)
Begin
insert into profile (Profile) values ('4cachercomptage')
End
If Not Exists(select * from Profile where CleProfile=371)
Begin
insert into profile (Profile) values ('1convention')
End
If Not Exists(select * from Profile where CleProfile=372)
Begin
insert into profile (Profile) values ('1conventionajout')
End
If Not Exists(select * from Profile where CleProfile=373)
Begin
insert into profile (Profile) values ('1conventionmod')
End
If Not Exists(select * from Profile where CleProfile=374)
Begin
insert into profile (Profile) values ('1conventionsupp')
End
If Not Exists(select * from Profile where CleProfile=375)
Begin
insert into profile (Profile) values ('1conventionverr')
End
If Not Exists(select * from Profile where CleProfile=376)
Begin
insert into profile (Profile) values ('7docconvention')
End
If Not Exists(select * from Profile where CleProfile=377)
Begin
insert into profile (Profile) values ('7docconventionajout')
End
If Not Exists(select * from Profile where CleProfile=378)
Begin
insert into profile (Profile) values ('7docconventionmod')
End
If Not Exists(select * from Profile where CleProfile=379)
Begin
insert into profile (Profile) values ('7docconventionsupp')
End
If Not Exists(select * from Profile where CleProfile=380)
Begin
insert into profile (Profile) values ('9preparateur')
End
If Not Exists(select * from Profile where CleProfile=381)
Begin
insert into profile (Profile) values ('9controleur')
End
If Not Exists(select * from Profile where CleProfile=382)
Begin
insert into profile (Profile) values ('1convention2')
End
If Not Exists(select * from Profile where CleProfile=383)
Begin
insert into profile (Profile) values ('1convention2ajout')
End
If Not Exists(select * from Profile where CleProfile=384)
Begin
insert into profile (Profile) values ('1convention2mod')
End
If Not Exists(select * from Profile where CleProfile=385)
Begin
insert into profile (Profile) values ('1convention2supp')
End
If Not Exists(select * from Profile where CleProfile=386)
Begin
insert into profile (Profile) values ('1convention2verr')
End
If Not Exists(select * from Profile where CleProfile=387)
Begin
insert into profile (Profile) values ('6caclmarque')
End
If Not Exists(select * from Profile where CleProfile=388)
Begin
insert into profile (Profile) values ('cptjournalreglement')
End
If Not Exists(select * from Profile where CleProfile=389)
Begin
insert into profile (Profile) values ('cptinstance')
End
If Not Exists(select * from Profile where CleProfile=390)
Begin
insert into profile (Profile) values ('cptordonnacier')
End
If Not Exists(select * from Profile where CleProfile=391)
Begin
insert into profile (Profile) values ('cptbordereau')
End
If Not Exists(select * from Profile where CleProfile=392)
Begin
insert into profile (Profile) values ('cpttrace')
End
If Not Exists(select * from Profile where CleProfile=393)
Begin
insert into profile (Profile) values ('cptasscnas')
End
If Not Exists(select * from Profile where CleProfile=394)
Begin
insert into profile (Profile) values ('cptetat')
End
If Not Exists(select * from Profile where CleProfile=395)
Begin
insert into profile (Profile) values ('cptdossier')
End
If Not Exists(select * from Profile where CleProfile=396)
Begin
insert into profile (Profile) values ('cptoption')
End
If Not Exists(select * from Profile where CleProfile=397)
Begin
insert into profile (Profile) values ('8controle')
End
If Not Exists(select * from Profile where CleProfile=398)
Begin
insert into profile (Profile) values ('4depot')
End
If Not Exists(select * from Profile where CleProfile=399)
Begin
insert into profile (Profile) values ('cptprix')
End
If Not Exists(select * from Profile where CleProfile=400)
Begin
insert into profile (Profile) values ('cptremise')
End
If Not Exists(select * from Profile where CleProfile=401)
Begin
insert into profile (Profile) values ('9statuttiers')
End
If Not Exists(select * from Profile where CleProfile=402)
Begin
insert into profile (Profile) values ('4invrapide')
End
If Not Exists(select * from Profile where CleProfile=403)
Begin
insert into profile (Profile) values ('4clotureinvrapide')
End
If Not Exists(select * from Profile where CleProfile=404)
Begin
insert into profile (Profile) values ('1journaldette')
End
If Not Exists(select * from Profile where CleProfile=405)
Begin
insert into profile (Profile) values ('2journalcreance')
End
If Not Exists(select * from Profile where CleProfile=406)
Begin
insert into profile (Profile) values ('7imppsycho')
End
If Not Exists(select * from Profile where CleProfile=407)
Begin
insert into profile (Profile) values ('7creationrcfr')
End
If Not Exists(select * from Profile where CleProfile=408)
Begin
insert into profile (Profile) values ('7creationrccl')
End
If Not Exists(select * from Profile where CleProfile=409)
Begin
insert into profile (Profile) values ('7imppsychocontrole')
End
If Not Exists(select * from Profile where CleProfile=410)
Begin
insert into profile (Profile) values ('6cagnote')
End
If Not Exists(select * from Profile where CleProfile=411)
Begin
insert into profile (Profile) values ('3ugremisevente')
End
If Not Exists(select * from Profile where CleProfile=412)
Begin
insert into profile (Profile) values ('4ordrecreation')
End
If Not Exists(select * from Profile where CleProfile=413)
Begin
insert into profile (Profile) values ('5valideweekend')
End
If Not Exists(select * from Profile where CleProfile=414)
Begin
insert into profile (Profile) values ('3fusionproduit')
End
If Not Exists(select * from Profile where CleProfile=415)
Begin
insert into profile (Profile) values ('3fusionlot')
End
If Not Exists(select * from Profile where CleProfile=416)
Begin
insert into profile (Profile) values ('1fusionfrs')
End
If Not Exists(select * from Profile where CleProfile=417)
Begin
insert into profile (Profile) values ('2fusioncl')
End
If Not Exists(select * from Profile where CleProfile=418)
Begin
insert into profile (Profile) values ('10fusionfrs')
End
If Not Exists(select * from Profile where CleProfile=419)
Begin
insert into profile (Profile) values ('7montantmin')
End
If Not Exists(select * from Profile where CleProfile=420)
Begin
insert into profile (Profile) values ('7montantmax')
End
If Not Exists(select * from Profile where CleProfile=421)
Begin
insert into profile (Profile) values ('6caclmarqueedit')
End
If Not Exists(select * from Profile where CleProfile=422)
Begin
insert into profile (Profile) values ('7alerteugtiers')
End
If Not Exists(select * from Profile where CleProfile=423)
Begin
insert into profile (Profile) values ('7remisemaxpers')
End
If Not Exists(select * from Profile where CleProfile=424)
Begin
insert into profile (Profile) values ('9classe')
End
If Not Exists(select * from Profile where CleProfile=425)
Begin
insert into profile (Profile) values ('3lotperime')
End
If Not Exists(select * from Profile where CleProfile=426)
Begin
insert into profile (Profile) values ('1objectif')
End
If Not Exists(select * from Profile where CleProfile=427)
Begin
insert into profile (Profile) values ('1objectifmod')
End
If Not Exists(select * from Profile where CleProfile=428)
Begin
insert into profile (Profile) values ('2crm')
End
If Not Exists(select * from Profile where CleProfile=429)
Begin
insert into profile (Profile) values ('2crmajout')
End
If Not Exists(select * from Profile where CleProfile=430)
Begin
insert into profile (Profile) values ('2crmsupp')
End
If Not Exists(select * from Profile where CleProfile=431)
Begin
insert into profile (Profile) values ('2crmmod')
End
If Not Exists(select * from Profile where CleProfile=432)
Begin
insert into profile (Profile) values ('9form')
End
If Not Exists(select * from Profile where CleProfile=433)
Begin
insert into profile (Profile) values ('9coefficient')
End
If Not Exists(select * from Profile where CleProfile=434)
Begin
insert into profile (Profile) values ('2crmmodif')
End
If Not Exists(select * from Profile where CleProfile=435)
Begin
insert into profile (Profile) values ('1fournisseurmoduser')
End
If Not Exists(select * from Profile where CleProfile=436)
Begin
insert into profile (Profile) values ('1clientmoduser')
End
If Not Exists(select * from Profile where CleProfile=437)
Begin
insert into profile (Profile) values ('1fournisseurmoduser2')
End
If Not Exists(select * from Profile where CleProfile=438)
Begin
insert into profile (Profile) values ('2clientmoduser2')
End
If Not Exists(select * from Profile where CleProfile=439)
Begin
insert into profile (Profile) values ('2CRMaffecter')
End
If Not Exists(select * from Profile where CleProfile=440)
Begin
insert into profile (Profile) values ('2CRMObsCmd')
End
If Not Exists(select * from Profile where CleProfile=441)
Begin
insert into profile (Profile) values ('9libelle')
End
If Not Exists(select * from Profile where CleProfile=442)
Begin
insert into profile (Profile) values ('2CRMajoutProduit')
End
If Not Exists(select * from Profile where CleProfile=443)
Begin
insert into profile (Profile) values ('2CRMsuppProduit')
End
If Not Exists(select * from Profile where CleProfile=444)
Begin
insert into profile (Profile) values ('5letragepartiel')
End
If Not Exists(select * from Profile where CleProfile=445)
Begin
insert into profile (Profile) values ('7imppreparer')
End
If Not Exists(select * from Profile where CleProfile=446)
Begin
insert into profile (Profile) values ('7verrpreparer')
End
If Not Exists(select * from Profile where CleProfile=447)
Begin
insert into profile (Profile) values ('7etatascend')
End
If Not Exists(select * from Profile where CleProfile=448)
Begin
insert into profile (Profile) values ('3quotaeditmanuel')
End
If Not Exists(select * from Profile where CleProfile=449)
Begin
insert into profile (Profile) values ('6creancefrs')
End
If Not Exists(select * from Profile where CleProfile=450)
Begin
insert into profile (Profile) values ('7Coefpiece')
End
If Not Exists(select * from Profile where CleProfile=451)
Begin
insert into profile (Profile) values ('7modifannee')
End
If Not Exists(select * from Profile where CleProfile=452)
Begin
insert into profile (Profile) values ('7modifmois')
End
If Not Exists(select * from Profile where CleProfile=453)
Begin
insert into profile (Profile) values ('7modifmoisp')
End
If Not Exists(select * from Profile where CleProfile=454)
Begin
insert into profile (Profile) values ('7imprc')
End
If Not Exists(select * from Profile where CleProfile=455)
Begin
insert into profile (Profile) values ('7impbr')
End
If Not Exists(select * from Profile where CleProfile=456)
Begin
insert into profile (Profile) values ('7imprf')
End
If Not Exists(select * from Profile where CleProfile=457)
Begin
insert into profile (Profile) values ('7impbcf')
End
If Not Exists(select * from Profile where CleProfile=458)
Begin
insert into profile (Profile) values ('7impbcc')
End
If Not Exists(select * from Profile where CleProfile=459)
Begin
insert into profile (Profile) values ('7impfv')
End
If Not Exists(select * from Profile where CleProfile=460)
Begin
insert into profile (Profile) values ('7impav')
End
If Not Exists(select * from Profile where CleProfile=461)
Begin
insert into profile (Profile) values ('7impfa')
End
If Not Exists(select * from Profile where CleProfile=462)
Begin
insert into profile (Profile) values ('7impaa')
End
If Not Exists(select * from Profile where CleProfile=463)
Begin
insert into profile (Profile) values ('7impbl')
End
If Not Exists(select * from Profile where CleProfile=464)
Begin
insert into profile (Profile) values ('7imprcf')
End
If Not Exists(select * from Profile where CleProfile=465)
Begin
insert into profile (Profile) values ('7imprcc')
End
If Not Exists(select * from Profile where CleProfile=466)
Begin
insert into profile (Profile) values ('7ajusterprix')
End
If Not Exists(select * from Profile where CleProfile=467)
Begin
insert into profile (Profile) values ('5prime')
End
If Not Exists(select * from Profile where CleProfile=468)
Begin
insert into profile (Profile) values ('5primeaj')
End
If Not Exists(select * from Profile where CleProfile=469)
Begin
insert into profile (Profile) values ('5primemod')
End
If Not Exists(select * from Profile where CleProfile=470)
Begin
insert into profile (Profile) values ('5primesupp')
End
If Not Exists(select * from Profile where CleProfile=471)
Begin
insert into profile (Profile) values ('5primeverr')
End
If Not Exists(select * from Profile where CleProfile=472)
Begin
insert into profile (Profile) values ('5primecal')
End
If Not Exists(select * from Profile where CleProfile=473)
Begin
insert into profile (Profile) values ('5primejournal')
End
If Not Exists(select * from Profile where CleProfile=474)
Begin
insert into profile (Profile) values ('7qtemax')
End
If Not Exists(select * from Profile where CleProfile=475)
Begin
insert into profile (Profile) values ('3lotqtegarde')
End
If Not Exists(select * from Profile where CleProfile=476)
Begin
insert into profile (Profile) values ('5journalfrs')
End
If Not Exists(select * from Profile where CleProfile=477)
Begin
insert into profile (Profile) values ('5journalcl')
End
If Not Exists(select * from Profile where CleProfile=478)
Begin
insert into profile (Profile) values ('5journalautre')
End
If Not Exists(select * from Profile where CleProfile=479)
Begin
insert into profile (Profile) values ('5primeimp')
End
If Not Exists(select * from Profile where CleProfile=480)
Begin
insert into profile (Profile) values ('5primelimite')
End
GO

If Not Exists(select * from UpTypeSalarie where CleTypeSalarie=1)
Begin
insert into UpTypeSalarie (Code,TypeSalarie) values ('','Mensuel')
End
If Not Exists(select * from UpTypeSalarie where CleTypeSalarie=2)
Begin
insert into UpTypeSalarie (Code,TypeSalarie) values ('','Hebdomadaire')
End
If Not Exists(select * from UpTypeSalarie where CleTypeSalarie=3)
Begin
insert into UpTypeSalarie (Code,TypeSalarie) values ('','Journalier')
End

GO
SET IDENTITY_INSERT [dbo].[UpTypeDoc] ON 
GO
If Not Exists(select * from UpTypeDoc where CleTypeDoc=1)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (1, N'1', N'Certificat de travail', NULL, N'CT', 1, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=2)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (2, N'2', N'Attestation de travail', NULL, N'AT', 3, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=3)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (3, N'3', N'Contrat de travail', NULL, N'CD', 1, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=4)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (4, N'4', N'PV d''installation', NULL, N'PV', 1, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=5)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (5, N'5', N'Ordre de mission', NULL, N'OM', 1, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=6)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (6, N'6', N'Fiche de notation individuelle', NULL, N'FNI', 1, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=7)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (7, N'7', N'Décision', NULL, N'DC', 1, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=8)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (8, N'8', N'Titre de congé', NULL, N'TC', 1, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=9)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (9, N'9', N'Déclaration sur l''honneur', NULL, N'DH', 1, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=10)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (10, N'10', N'Questionnaire', NULL, N'QU', 1, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=11)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (11, N'11', N'Avertissement', NULL, N'AV', 1, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=12)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (12, N'12', N'Blame', NULL, N'BL', 1, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=13)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (13, N'13', N'Changement de poste', NULL, N'CP', 1, 5, 1)
End
If Not Exists(select * from UpTypeDoc where CleTypeDoc=14)
Begin
INSERT [dbo].[UpTypeDoc] ([CleTypeDoc], [Code], [TypeDoc], [TypeDocArabe], [Prefix], [Next], [Size], [bAuto]) VALUES (14, N'14', N'Changement de salaire', NULL, N'CS', 1, 5, 1)
End
GO
SET IDENTITY_INSERT [dbo].[UpTypeDoc] OFF
GO
SET IDENTITY_INSERT [dbo].[UpTypeContrat] ON 
GO
If Not Exists(select * from UpTypeContrat where CleTypeContrat=1)
Begin
INSERT [dbo].[UpTypeContrat] ([CleTypeContrat], [Code], [TypeContrat], [TypeContratArabe]) VALUES (1, N'C1', N'CDI', N'')
End
If Not Exists(select * from UpTypeContrat where CleTypeContrat=2)
Begin
INSERT [dbo].[UpTypeContrat] ([CleTypeContrat], [Code], [TypeContrat], [TypeContratArabe]) VALUES (2, N'C0', N'CDD', N'')
End
If Not Exists(select * from UpTypeContrat where CleTypeContrat=3)
Begin
INSERT [dbo].[UpTypeContrat] ([CleTypeContrat], [Code], [TypeContrat], [TypeContratArabe]) VALUES (3, N'C2', N'Stage', N'')
End
GO
SET IDENTITY_INSERT [dbo].[UpTypeContrat] OFF
GO
SET IDENTITY_INSERT [dbo].[UpRubrique] ON 
GO
If Not Exists(select * from UpRubrique where CleRubrique=1)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (1, N'100', N'SALAIRE BASE MENSUEL     ', N'', 1, 1, 1, 1, 0, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 0, N'R00', N'T00', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=2)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (2, N'101', N'SAL.BASE JOURNALIER      ', N'', 1, 1, 1, 1, 0, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 1, N'R01', N'T01', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=3)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (3, N'102', N'SALAIRE BASE HORAIRE     ', N'', 1, 1, 1, 1, 0, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=4)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (4, N'300', N'RET. S/S (CNASAT)        ', N'', 0, 1, 0, 1, 2, 9.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'545000  ', N'459645.24', 0, N'RSS', N'TSS', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=5)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (5, N'400', N'RET. I R G               ', N'', 0, 0, 0, 1, 3, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'44210', N'668877.16', 0, N'RTS', N'TTS', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=6)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (6, N'099', N'SALAIRE GERANT /COGERANT ', N'', 0, 0, 1, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'633000  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=7)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (7, N'999', N'NET A PAYER              ', N'', 0, 0, 0, 1, 5, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'426000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=12)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (12, N'111', N'IND. NUISANCES           ', N'', 1, 1, 1, 1, 1, 0.0000, 0.0000, 0, 1, 0, 1, 0.0000, N'63022   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=13)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (13, N'112', N'IND. INSALUBRITE         ', N'', 1, 1, 1, 1, 1, 0.0000, 0.0000, 0, 1, 0, 1, 0.0000, N'631052  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=14)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (14, N'113', N'IND. SALISSURE           ', N'', 0, 0, 1, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631053  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=15)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (15, N'114', N'IND. PENEBILITE          ', N'', 1, 1, 1, 1, 1, 0.0000, 0.0000, 0, 1, 0, 1, 0.0000, N'631054  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=16)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (16, N'115', N'IND. DANGER              ', N'', 1, 1, 1, 1, 1, 0.0000, 0.0000, 0, 1, 0, 1, 0.0000, N'631055  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=17)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (17, N'116', N'BONIF. ANCIEN MOUDJAHID  ', N'', 1, 1, 1, 1, 1, 0.0000, 0.0000, 0, 1, 0, 1, 0.0000, N'63270   ', N'0', 1, N'R16', N'T16', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=18)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (18, N'117', N'PRIME DE PONCTUALITE     ', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63201   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=19)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (19, N'118', N'PRESALAIRE STAGIAIRE     ', N'', 1, 1, 1, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63421   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=20)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (20, N'119', N'I.T.P. 12.5 %            ', N'', 1, 1, 1, 1, 1, 1.0830, 0.0000, 0, 1, 0, 1, 0.0000, N'63230   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=21)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (21, N'120', N'I.T.P. 20 %              ', N'', 1, 1, 1, 1, 1, 1.7330, 0.0000, 0, 0, 0, 1, 0.0000, N'63230   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=22)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (22, N'121', N'I.T.P. 25 %              ', N'', 1, 1, 1, 1, 1, 2.2660, 0.0000, 0, 0, 0, 1, 0.0000, N'63230   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=23)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (23, N'122', N'I.T.P. 05 %              ', N'', 1, 1, 1, 1, 1, 0.4330, 0.0000, 0, 0, 0, 1, 0.0000, N'63230   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=24)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (24, N'123', N'PRIME D''ENCOURAGEMENT    ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'634220  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=25)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (25, N'124', N'IND. TRAVAIL SUR MICRO   ', N'', 0, 0, 1, 1, 1, 200.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63----  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=26)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (26, N'125', N'PRIME DE BILAN           ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63024   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=27)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (27, N'150', N'IND. CONGE (COT.& IMPOS.)', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630300  ', N'92.5', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=28)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (28, N'151', N'IND CONGE PAYE           ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630300  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=29)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (29, N'250', N'PRIME DE RISQUE          ', N'', 1, 1, 1, 1, 1, 10000.0000, 0.0000, 0, 0, 0, 1, 1.0000, N'631010  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=30)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (30, N'251', N'P.R.C (TAUX)             ', N'', 1, 1, 1, 1, 1, 0.0000, 0.0000, 0, 1, 0, 1, 0.0000, N'630210  ', N'0', 1, N'R51', N'T51', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=31)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (31, N'252', N'PRIME PANIER JOUR        ', N'', 0, 1, 1, 0, 1, 300.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630200  ', N'276', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=32)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (32, N'253', N'PRIME PANIER NUIT        ', N'', 0, 1, 1, 1, 1, 160.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631020  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=33)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (33, N'254', N'IND. DE TRANSPORT        ', N'', 0, 1, 1, 0, 1, 200.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'632100  ', N'172', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=34)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (34, N'255', N'IND.VEHICULE             ', N'', 0, 1, 1, 0, 1, 800.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'632000  ', N'142', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=35)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (35, N'256', N'IND. ZONE GEOGRAPHIQUE   ', N'', 0, 1, 1, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63211   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=36)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (36, N'257', N'PRIME DE RESPONSABILITE  ', N'', 1, 1, 1, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631000  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=37)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (37, N'259', N'PRIME DE CAISSE          ', N'', 0, 0, 1, 1, 1, 500.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63333   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=38)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (38, N'260', N'IND. CONGE (IMPOSABLE)   ', N'', 1, 0, 1, 0, 1, 0.3330, 0.0000, 0, 0, 0, 1, 0.0000, N'630300  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=40)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (40, N'361', N'IND. CONGE (NON COT.&IMP)', N'', 0, 0, 1, 0, 1, 0.3330, 0.0000, 0, 0, 0, 1, 0.0000, N'63030   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=41)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (41, N'383', N'REMB.FRAIS MEDICAL CNASAT', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'46305   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=42)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (42, N'384', N'REMB.FRAIS MEDICAL C M A ', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'46306   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=43)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (43, N'385', N'OPPOSITION ADMINISTRATIVE', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'54600   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=44)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (44, N'386', N'SALAIRE APPRENTI         ', N'', 0, 0, 1, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=45)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (45, N'387', N'RETENUE IMPOT DE SOLIDARI', N'', 0, 0, 0, 1, 1, 0.0000, 0.0000, 0, 1, 0, 1, 0.0000, N'555555  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=47)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (47, N'430', N'RET. ABSENCE AUTORISE    ', N'', 1, 1, 0, 0, 4, 100.0000, 0.0000, 1, 0, 0, 1, 100.0000, N'630000  ', N'123.5', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=48)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (48, N'431', N'RET. ANNUL PAEI          ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 1, 0, 0, 1, 0.0000, N'630000  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=49)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (49, N'432', N'RET. MALADIE             ', N'', 1, 1, 0, 0, 4, 0.0000, 0.0000, 1, 0, 0, 1, 100.0000, N'630000  ', N'3', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=50)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (50, N'433', N'RET. ACCIDENT TRAVAIL    ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 1, 0, 0, 1, 0.0000, N'630000  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=51)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (51, N'434', N'RET. CONGE SANS SOLDE    ', N'', 1, 1, 0, 0, 4, 0.0000, 0.0000, 1, 0, 0, 1, 100.0000, N'630000  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=52)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (52, N'435', N'RET. MISE A PIED         ', N'', 1, 1, 0, 1, 1, 0.0000, 0.0000, 1, 0, 0, 1, 0.0000, N'630000  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=53)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (53, N'491', N'RET. AVANCES SUR SALAIRES', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'463100  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=54)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (54, N'492', N'RET. AVANCES SUR MISSION ', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'463100  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=55)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (55, N'493', N'RET. PRET                ', N'', 0, 0, 0, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'463100  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=56)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (56, N'494', N'RET. COSMETIQUE          ', N'', 0, 0, 0, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'46314   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=57)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (57, N'495', N'RET. PRET VEHICULE       ', N'', 0, 0, 0, 1, 1, 0.0000, 0.0000, 0, 0, 1, 1, 0.0000, N'46312   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=58)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (58, N'496', N'RET. SUR MEDICAMENTS     ', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'463100  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=59)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (59, N'497', N'RET. LOYER               ', N'', 0, 0, 0, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'77930   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=60)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (60, N'498', N'RET. ASSURANCE GROUPE    ', N'', 0, 0, 0, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'54800   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=61)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (61, N'499', N'RET. PRIME DE PANIER     ', N'', 0, 0, 0, 1, 1, 70.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'549000  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=62)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (62, N'500', N'TROP PERCU A REGULARISER ', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'56320   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=63)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (63, N'502', N'TROP PERCU S/BASE A TORT ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'563100  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=64)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (64, N'503', N'TROP PERCU A TORT        ', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'00000   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=65)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (65, N'990', N'COTISATION S/S PATRONALE ', N'', 0, 0, 1, 1, 1, 26.0000, 0.0000, 0, 0, 0, 0, 300.0000, N'635000  ', N'568100', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=66)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (66, N'991', N'VERSEMENT FORFAITAIRE    ', N'', 0, 0, 1, 0, 4, 0.0000, 0.0000, 0, 0, 0, 0, 400.0000, N'640000  ', N'564000', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=67)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (67, N'C49', N'COMPLEMENT CONGE NON C/I ', N'', 0, 0, 1, 0, 1, 0.3330, 0.0000, 0, 0, 0, 1, 0.0000, N'63030   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=68)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (68, N'C50', N'COMPLEMENT CONGE COT/IMP.', N'', 1, 1, 1, 0, 1, 0.3330, 0.0000, 0, 0, 0, 1, 0.0000, N'63030   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=69)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (69, N'N01', N'IND.NUISANCES 1 %        ', N'', 1, 1, 1, 1, 1, 0.0870, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=70)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (70, N'N02', N'IND.NUISANCES 2 %        ', N'', 1, 1, 1, 1, 1, 0.1730, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=71)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (71, N'N03', N'IND.NUISANCES 3 %        ', N'', 1, 1, 1, 1, 1, 0.2600, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=72)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (72, N'N10', N'IND.NUISANCES 10 %       ', N'', 1, 1, 1, 1, 1, 0.8660, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=73)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (73, N'N11', N'IND.NUISANCES 11 %       ', N'', 1, 1, 1, 1, 1, 0.9530, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=74)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (74, N'N12', N'IND.NUISANCES 12 %       ', N'', 1, 1, 1, 1, 1, 1.0390, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=76)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (76, N'N20', N'IND.NUISANCES 20 %       ', N'', 1, 1, 1, 1, 1, 1.7320, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=77)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (77, N'R00', N'RAP. SALAIRE BASE MENSUEL', N'', 1, 1, 1, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=78)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (78, N'R01', N'RAP. SALAIRE GERANT      ', N'', 0, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=79)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (79, N'R02', N'RAP. SALAIRE BASE HORAIRE', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=80)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (80, N'R03', N'RAP. I E P               ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63240   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=81)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (81, N'R04', N'RAP. H.S NORMALES        ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63000   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=82)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (82, N'R05', N'RAP. H.S 50 %            ', N'', 1, 1, 1, 0, 1, 1.5000, 0.0000, 0, 0, 0, 1, 0.0000, N'63020   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=83)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (83, N'R06', N'RAP. H.S 75 %            ', N'', 1, 1, 1, 0, 1, 1.7500, 0.0000, 0, 0, 0, 1, 0.0000, N'63020   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=84)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (84, N'R07', N'RAP. H.S 100 %           ', N'', 1, 1, 1, 0, 1, 2.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63020   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=85)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (85, N'R08', N'RAP. P R I (MONTANT)     ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631040  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=86)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (86, N'R09', N'RAP. IND. TRAVAIL POSTE  ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63230   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=87)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (87, N'R10', N'RAP. I F S P             ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63220   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=88)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (88, N'R11', N'RAP. IND. NUISANCES      ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=89)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (89, N'R12', N'RAP. IND. INSALUBRITE    ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631052  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=90)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (90, N'R13', N'RAP. IND. SALISSURE      ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631053  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=91)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (91, N'R14', N'RAP. IND. PENIBILITE     ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631054  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=92)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (92, N'R15', N'RAP. IND. DANGER         ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631055  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=93)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (93, N'R16', N'RAP. BONIF.ANC.MOUDJAHID ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63270   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=94)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (94, N'362', N'IND.FEMME AU FOYER (IPSU)', N'', 0, 0, 1, 1, 1, 500.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63201   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=95)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (95, N'363', N'IND. COMPL.AF. (ICAF)    ', N'', 0, 0, 1, 1, 1, 60.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'46304   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=96)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (96, N'375', N'PRIME DE SCOLARITE       ', N'', 0, 0, 1, 0, 1, 250.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63295   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=97)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (97, N'376', N'PRIME DE DEPLACEMENT     ', N'', 0, 0, 1, 0, 1, 500.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'627600  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=98)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (98, N'377', N'PRIME D''INVENTAIRE       ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63296   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=99)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (99, N'378', N'COTISATION C M A         ', N'', 0, 0, 0, 1, 1, 60.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'54540   ', N'0', 0, N'R78', N'R78', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=100)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (100, N'379', N'COTISATION C M A- COMPLEM', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'54540   ', N'0', 0, N'R78', N'R78', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=101)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (101, N'380', N'REMB.FRAIS MISSION       ', N'', 0, 0, 1, 0, 1, 1000.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'62710   ', N'37', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=102)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (102, N'R31', N'RAP. RET. ABSENCES IRREGU', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=103)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (103, N'R32', N'RAP. RET. MALADIE        ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=104)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (104, N'R33', N'RAP. RET. ACCID. TRAVAIL ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=105)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (105, N'R34', N'RAP. RET. PRIME DE PANIER', N'', 0, 0, 0, 0, 1, 70.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'632100  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=106)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (106, N'R35', N'RAP. RET. MISE A PIED    ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=107)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (107, N'R56', N'RAP. IND. ZONE GEOGRAPHIQ', N'', 0, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63211   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=108)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (108, N'R57', N'RAP. PRIME RESPONSABILITE', N'', 0, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631051  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=109)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (109, N'R59', N'RAP. PRIME DE LAIT       ', N'', 0, 1, 1, 0, 1, 1.5000, 0.0000, 0, 0, 0, 1, 0.0000, N'00      ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=110)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (110, N'370', N'I F R I (TAUX)           ', N'', 0, 0, 1, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63210   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=111)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (111, N'371', N'I F R I (MONTANT)        ', N'', 0, 0, 1, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63210   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=112)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (112, N'372', N'A F                      ', N'', 0, 0, 1, 1, 1, 200.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'4580    ', N'0', 0, N'R72', N'T72', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=113)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (113, N'373', N'IND. DEPART              ', N'', 1, 1, 1, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63292   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=114)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (114, N'374', N'SALAIRE UNIQUE           ', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63026   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=115)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (115, N'381', N'REMB.FORFAIT.FRAI MISSION', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'62730   ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=116)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (116, N'382', N'REMB.FRAIS DE CARBURANT  ', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'46304   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=117)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (117, N'R78', N'RAP. CMA RETENUE A TORT  ', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'54540   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=118)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (118, N'R80', N'RAP. REMB.F/MISSION VOYAG', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'62710   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=119)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (119, N'R81', N'RAP. REMB.F/MISSION HEBER', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'62730   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=120)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (120, N'R85', N'RAP. S/OPPOSIT. ADMINIST.', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'54600   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=121)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (121, N'R86', N'RAP. SALAIRE BASE P/ESSAI', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=122)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (122, N'R91', N'RAP. RET.AVANCE S/SALAIRE', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'46301   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=123)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (123, N'R98', N'RAP. RET.ASSURANCE GROUPE', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'54800   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=124)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (124, N'R99', N'RET. RAP. S/BASE P/ESSAI ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'633000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=125)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (125, N'RSS', N'COMPLEMENT RETENUE SS    ', N'', 0, 0, 0, 0, 1, 0.0700, 0.0000, 0, 0, 0, 1, 0.0000, N'54500   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=126)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (126, N'RTS', N'COMPLEMENT RETENUE I.T.S ', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'543100  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=127)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (127, N'S01', N'AMENDES RETARD           ', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63...   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=128)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (128, N'T00', N'T.P. SALAIRE BASE MENSUEL', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=129)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (129, N'T01', N'T.P. SALAIRE CO-GERANT   ', N'', 0, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'633000  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=130)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (130, N'T02', N'T.P. SALAIRE BASE HORAIRE', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=131)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (131, N'T03', N'T.P. I.E.P (MONTANT)     ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63240   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=132)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (132, N'T08', N'T.P. P.R.I (MONTANT)     ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631040  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=133)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (133, N'T09', N'T.P. I.T.P (MONTANT)     ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63230   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=134)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (134, N'T10', N'T.P. I.F.S.P (MONTANT)   ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63220   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=136)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (136, N'C48', N'COMPLEMENT CONGE (IMPOS.)', N'', 0, 1, 1, 0, 1, 0.3330, 0.0000, 0, 0, 0, 1, 0.0000, N'630300  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=137)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (137, N'N04', N'IND.NUISANCES 4 %        ', N'', 1, 1, 1, 1, 1, 0.3460, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=138)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (138, N'N05', N'IND.NUISANCES 5 %        ', N'', 1, 1, 1, 1, 1, 0.4330, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=139)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (139, N'N06', N'IND.NUISANCES 6 %        ', N'', 1, 1, 1, 1, 1, 0.5190, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=140)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (140, N'N07', N'IND.NUISANCES 7 %        ', N'', 1, 1, 1, 1, 1, 0.6060, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=141)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (141, N'N08', N'IND.NUISANCES 8 %        ', N'', 1, 1, 1, 1, 1, 0.6930, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=142)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (142, N'N09', N'IND.NUISANCES 9 %        ', N'', 1, 1, 1, 1, 1, 0.7790, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=143)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (143, N'T11', N'T.P. IND. NUISANCES      ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=144)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (144, N'T12', N'T.P. IND. INSALUBRITE    ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631052  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=145)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (145, N'T13', N'T.P. IND. SALISSURE      ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631053  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=146)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (146, N'T14', N'T.P. IND. PENIBILITE     ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631054  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=147)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (147, N'T15', N'T.P. IND. DANGER         ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631055  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=148)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (148, N'T16', N'T.P. BONIF.ANC.MOUDJAHID ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63270   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=149)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (149, N'T17', N'T.P. IND. INTERIM (DIF.) ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63285   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=150)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (150, N'T18', N'T.P. PRESALAIRE STAGIAIRE', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63421   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=151)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (151, N'N13', N'IND.NUISANCES 13 %       ', N'', 1, 1, 1, 1, 1, 1.1260, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=152)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (152, N'N14', N'IND.NUISANCES 14 %       ', N'', 1, 1, 1, 1, 1, 1.2120, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=153)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (153, N'N15', N'IND.NUISANCES 15 %       ', N'', 1, 1, 1, 1, 1, 1.2990, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=154)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (154, N'N16', N'IND.NUISANCES 16 %       ', N'', 1, 1, 1, 1, 1, 1.3850, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=155)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (155, N'N17', N'IND.NUISANCES 17 %       ', N'', 1, 1, 1, 1, 1, 1.4720, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=156)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (156, N'N18', N'IND.NUISANCES 18 %       ', N'', 1, 1, 1, 1, 1, 1.5590, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=157)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (157, N'N19', N'IND.NUISANCES 19 %       ', N'', 1, 1, 1, 1, 1, 1.6450, 0.0000, 0, 0, 0, 1, 0.0000, N'63255   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=158)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (158, N'T50', N'T.P. IND. CONGES PAYES   ', N'', 1, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63030   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=159)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (159, N'T51', N'T.P. P R C (MONTANT)     ', N'', 0, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631030  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=160)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (160, N'T52', N'T.P. PRIME PANIER JOUR   ', N'', 0, 1, 0, 0, 1, 15.7200, 0.0000, 0, 0, 0, 1, 0.0000, N'631010  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=161)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (161, N'T53', N'T.P. PRIME PANIER NUIT   ', N'', 0, 1, 0, 0, 1, 15.7200, 0.0000, 0, 0, 0, 1, 0.0000, N'631010  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=162)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (162, N'T54', N'T.P. IND. DE TRANSPORT   ', N'', 0, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631020  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=163)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (163, N'T55', N'T.P. I F A V             ', N'', 0, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63200   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=164)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (164, N'T56', N'T.P. IND. ZONE GEOGRAPHIQ', N'', 0, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63211   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=165)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (165, N'T57', N'T.P. PRIME RESPONSABILITE', N'', 0, 1, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631051  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=166)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (166, N'T59', N'T.P. PRIME DE LAIT       ', N'', 0, 1, 0, 0, 1, 1.5000, 0.0000, 0, 0, 0, 1, 0.0000, N'00      ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=167)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (167, N'T71', N'T.P. I F R I             ', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63210   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=168)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (168, N'T72', N'T.P. A F                 ', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'56370   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=169)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (169, N'T73', N'T.P. IND. C A F          ', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63292   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=170)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (170, N'T74', N'T.P. SALAIRE UNIQUE      ', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63291   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=171)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (171, N'T75', N'T.P. PRIME SCOLARITE     ', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63295   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=172)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (172, N'T76', N'T.P. PRIME DE TROUSSEAU  ', N'', 0, 0, 0, 0, 1, 500.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63421   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=173)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (173, N'T77', N'T.P. PRIME OUTILLAGE     ', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63296   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=174)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (174, N'T80', N'T.P. FRAIS MISSION VOYAGE', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'62710   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=175)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (175, N'T81', N'T.P. FRAIS MISSION HEBERG', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'62730   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=176)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (176, N'T86', N'T.P. SALAIRE APPRENTI    ', N'', 0, 0, 0, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63000   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=177)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (177, N'TSS', N'SA                       ', N'', 0, 0, 1, 1, 1, 0.0900, 0.0000, 0, 0, 0, 1, 0.0000, N'545100  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=178)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (178, N'TST', N'REMB. S/S EMPLOYE        ', N'', 0, 0, 1, 0, 1, 0.0900, 0.0000, 0, 0, 0, 1, 0.0000, N'545100  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=179)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (179, N'TTS', N'REMB. I T S              ', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'543100  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=180)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (180, N'457', N'RET. PRIME RESPONSABILITE', N'', 1, 1, 0, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=181)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (181, N'388', N'RET. RETARD              ', N'', 1, 1, 0, 1, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=182)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (182, N'436', N'RET. ABSENCE NON AUTORISE', N'', 1, 1, 0, 1, 4, 0.0000, 0.0000, 1, 0, 0, 1, 100.0000, N'630000  ', N'8', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=183)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (183, N'R18', N'RAP. PRESALAIRE STAGIAIRE', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63421   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=184)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (184, N'R30', N'RAP. RET. ABSENCES AUTORI', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630000  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=185)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (185, N'R50', N'RAP. IND. CONGES PAYES   ', N'', 1, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630300  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=186)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (186, N'R51', N'RAP. P R C (MONTANT)     ', N'', 0, 1, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'631030  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=187)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (187, N'R52', N'RAP. PRIME DE TRANSPORT  ', N'', 0, 1, 1, 0, 1, 15.7200, 0.0000, 0, 0, 0, 1, 0.0000, N'631010  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=188)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (188, N'R53', N'RAP. PRIME PANIER NUIT   ', N'', 0, 1, 1, 0, 1, 15.7200, 0.0000, 0, 0, 0, 1, 0.0000, N'631010  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=189)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (189, N'R54', N'RAP. IND. DE TRANSPORT   ', N'', 0, 1, 1, 1, 1, 50.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'632110  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=190)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (190, N'R55', N'RAP. IND. VEHICULE       ', N'', 0, 1, 1, 1, 1, 500.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'632110  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=191)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (191, N'389', N'REMB.FRAIS TELECOM       ', N'', 0, 0, 1, 0, 1, 2000.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'62800   ', N'44', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=192)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (192, N'R62', N'RAP.FEMME AU FOYER (IPSU)', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63291   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=193)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (193, N'R71', N'RAP. I F R I             ', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63210   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=194)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (194, N'R72', N'RAP. PRIME PANIER JOUR   ', N'', 0, 1, 1, 1, 1, 150.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630210  ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=195)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (195, N'R73', N'RAP. IND. C A F          ', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63292   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=196)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (196, N'R74', N'RAP. SALAIRE UNIQUE      ', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63291   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=197)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (197, N'R75', N'RAP. PRIME DE SCOLARITE  ', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63295   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=198)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (198, N'R77', N'RAP. PRIME OUTILLAGE     ', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'63296   ', N'0', 0, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=199)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (199, N'105', N'H.S 50 %                 ', N'', 1, 1, 1, 0, 1, 1.5000, 0.0000, 0, 0, 0, 1, 0.0000, N'630100  ', N'12', 1, N'R05', N'R05', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=200)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (200, N'106', N'H.S 75 %                 ', N'', 1, 1, 1, 0, 1, 1.7500, 0.0000, 0, 0, 0, 1, 0.0000, N'630100  ', N'0', 1, N'R06', N'R06', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=201)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (201, N'107', N'H.S 100 %                ', N'', 1, 1, 1, 0, 1, 2.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630100  ', N'16', 1, N'R07', N'R07', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=202)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (202, N'108', N'P.R.I (TAUX)             ', N'', 1, 1, 1, 1, 1, 0.0000, 0.0000, 0, 1, 0, 1, 0.0000, N'630210  ', N'0', 1, N'R08', N'T08', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=203)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (203, N'109', N'IND. TRAVAIL POSTE SIEGE ', N'', 1, 1, 1, 1, 1, 0.0000, 25.0000, 0, 1, 0, 1, 0.0000, N'632400  ', N'0', 1, N'   ', N'   ', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=204)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (204, N'110', N'I.F.S.P                  ', N'', 1, 1, 1, 1, 1, 0.0000, 20.0000, 0, 1, 0, 1, 0.0000, N'63022   ', N'0', 1, N'R10', N'T10', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=205)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (205, N'103', N'IND. EXP. PROF.          ', N'', 1, 1, 1, 1, 1, 0.0000, 35.0000, 0, 1, 0, 1, 0.0000, N'632030  ', N'0', 1, N'R03', N'T03', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=206)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (206, N'104', N'HEURES NORMALES          ', N'', 1, 1, 1, 0, 1, 600.0000, 0.0000, 0, 0, 0, 1, 0.0000, N'630250  ', N'0', 1, N'R04', N'R04', 0)
End
If Not Exists(select * from UpRubrique where CleRubrique=207)
Begin
INSERT [dbo].[UpRubrique] ([CleRubrique], [Code], [Rubrique], [RubriqueArabe], [bSS], [bIRG], [bPositive], [bFixe], [Calcul], [Taux], [Limite], [bAbsence], [bProrata], [bEcheance], [bNormal], [Base], [CompteImputation], [CompteContrePartie], [NatureTiers], [RubriqueRappel], [RubriqueTropPercu], [bConge]) VALUES (207, N'390', N'PRIME DE SALISSURE', N'', 0, 0, 1, 0, 1, 0.0000, 0.0000, 0, 0, 0, 0, 0.0000, N'6310', N'', -1, N'', N'', 0)
End
GO
SET IDENTITY_INSERT [dbo].[UpRubrique] OFF
GO
SET IDENTITY_INSERT [dbo].[UpParametre] ON 
GO
If Not Exists(select * from UpParametre where CleParametre=1)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (1, N'nbrchifre', CAST(5 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=2)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (2, N'2codeauto', NULL, NULL, 1)
End
If Not Exists(select * from UpParametre where CleParametre=3)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (3, N'2taille', CAST(5 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=4)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (4, N'2cpt', CAST(1 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=5)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (5, N'2prefix', NULL, N'Emp', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=6)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (6, N'2direction', CAST(1 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=7)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (7, N'2fonction', CAST(22 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=8)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (8, N'2modepaiement', CAST(1 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=9)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (9, N'2bank', CAST(1 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=10)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (10, N'2etatcivil', CAST(1 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=11)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (11, N'2position', CAST(1 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=12)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (12, N'2typecontrat', CAST(2 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=13)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (13, N'2typesalaire', CAST(1 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=14)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (14, N'3nhj', CAST(8 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=15)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (15, N'3nhm', CAST(180 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=16)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (16, N'3njm', CAST(30 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=17)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (17, N'3njo', CAST(22 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=18)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (18, N'4sbm', NULL, N'100', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=19)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (19, N'4sbj', NULL, N'101', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=20)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (20, N'4sbh', NULL, N'102', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=21)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (21, N'4retss', NULL, N'300', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=22)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (22, N'4retirg', NULL, N'400', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=23)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (23, N'4retmut', NULL, N'500', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=24)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (24, N'4caco', NULL, N'', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=25)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (25, N'4net', NULL, N'999', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=26)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (26, N'4trop', NULL, N'', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=27)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (27, N'4retsspat', NULL, N'', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=28)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (28, N'4prc', NULL, N'', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=29)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (29, N'4rss', NULL, N'', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=30)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (30, N'4remss', NULL, N'', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=31)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (31, N'4rirg', NULL, N'', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=32)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (32, N'4remirg', NULL, N'', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=33)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (33, N'4congeimp', NULL, N'203', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=34)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (34, N'4congenoncotimp', NULL, N'204', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=35)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (35, N'4congenoncotnonimp', NULL, N'205', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=36)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (36, N'8mode', CAST(0 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=37)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (37, N'8conge', NULL, N'302', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=38)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (38, N'8112', NULL, N'310', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=39)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (39, N'8j0', CAST(0 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=40)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (40, N'8j8', CAST(8 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=41)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (41, N'8j15', CAST(15 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=42)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (42, N'8j30', CAST(30 AS Numeric(18, 0)), NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=43)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (43, N'13init', NULL, NULL, 1)
End
If Not Exists(select * from UpParametre where CleParametre=44)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (44, N'13archivage', NULL, NULL, 0)
End
If Not Exists(select * from UpParametre where CleParametre=45)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (45, N'13archivetime', NULL, NULL, 0)
End
If Not Exists(select * from UpParametre where CleParametre=46)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (46, N'13archivesemaine', NULL, NULL, 0)
End
If Not Exists(select * from UpParametre where CleParametre=47)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (47, N'13archivejour', NULL, NULL, 0)
End
If Not Exists(select * from UpParametre where CleParametre=48)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (48, N'13archiveheure', NULL, NULL, 1)
End
If Not Exists(select * from UpParametre where CleParametre=49)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (49, N'13archivedatetime', NULL, N'23:00:00', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=50)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (50, N'14archive1', NULL, N'D:\Sauvegarde\Backup.bak', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=51)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (51, N'14archive2', NULL, N'E:\Buckup\Backup.bak', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=52)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (52, N'15bchemin1', NULL, NULL, 1)
End
If Not Exists(select * from UpParametre where CleParametre=53)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (53, N'15bchemin2', NULL, NULL, 0)
End
If Not Exists(select * from UpParametre where CleParametre=54)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (54, N'15chemin1', NULL, N'\\SRV-HP-UPO\Reports', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=55)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (55, N'15chemin2', NULL, N'C:\Program Files (x86)\sCom\sCom2014\Reports', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=56)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (56, N'3absauto', 1, NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=57)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (57, N'3absnauto', 1, NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=58)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (58, N'3hs', 1, NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=59)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (59, N'3hs2', 1, NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=60)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (60, N'3conge', 1, NULL, NULL)
End
If Not Exists(select * from UpParametre where CleParametre=61)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (61, N'3hsentree', NULL, NULL, 0)
End
If Not Exists(select * from UpParametre where CleParametre=62)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (62, N'3hssortie', NULL, NULL, 1)
End
If Not Exists(select * from UpParametre where CleParametre=63)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (63, N'3nhpose', NULL, '01:00:00', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=64)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (64, N'3hnuit', NULL, '08:00:00', NULL)
End
If Not Exists(select * from UpParametre where CleParametre=65)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (65, N'3dpose', NULL, '12:30:00', NULL)
End
GO
If Not Exists(select * from UpParametre where CleParametre=66)
Begin
INSERT [dbo].[UpParametre] ([CleParametre], [Name], [Valeur], [Valeur2], [Valeur3]) VALUES (66, N'3maladie', 1, NULL, NULL)
End
GO
SET IDENTITY_INSERT [dbo].[UpParametre] OFF 
GO
Update [dbo].[UpParametre] set Valeur2='01:00:00' where (CleParametre=14) and (Valeur2 is null)
GO
SET IDENTITY_INSERT [dbo].[UpCategorieDoc] ON 
GO
If Not Exists(select * from UpCategorieDoc where CleCategorieDoc=1)
Begin
INSERT [dbo].[UpCategorieDoc] ([CleCategorieDoc], [Code], [CategorieDoc], [Notes], [Couleur], [bPrintable]) VALUES (1, N'1', N'Imprimé', N'', 16777215, 1)
End
If Not Exists(select * from UpCategorieDoc where CleCategorieDoc=2)
Begin
INSERT [dbo].[UpCategorieDoc] ([CleCategorieDoc], [Code], [CategorieDoc], [Notes], [Couleur], [bPrintable]) VALUES (2, N'2', N'Non imprimé', N'', 16777215, 1)
End
If Not Exists(select * from UpCategorieDoc where CleCategorieDoc=3)
Begin
INSERT [dbo].[UpCategorieDoc] ([CleCategorieDoc], [Code], [CategorieDoc], [Notes], [Couleur], [bPrintable]) VALUES (3, N'3', N'Annulé', N'', 16777215, 1)
End
GO
SET IDENTITY_INSERT [dbo].[UpCategorieDoc] OFF 
GO
SET IDENTITY_INSERT [dbo].[UpEtatCivil] ON 
GO
If Not Exists(select * from UpEtatCivil where CleEtatCivil=1)
Begin
INSERT [dbo].[UpEtatCivil] ([CleEtatCivil], [Code], [EtatCivil]) VALUES (1, N'1', N'Célibataire')
End
If Not Exists(select * from UpEtatCivil where CleEtatCivil=2)
Begin
INSERT [dbo].[UpEtatCivil] ([CleEtatCivil], [Code], [EtatCivil]) VALUES (2, N'2', N'Marié')
End
If Not Exists(select * from UpEtatCivil where CleEtatCivil=3)
Begin
INSERT [dbo].[UpEtatCivil] ([CleEtatCivil], [Code], [EtatCivil]) VALUES (3, N'3', N'Dévorcé')
End
If Not Exists(select * from UpEtatCivil where CleEtatCivil=4)
Begin
INSERT [dbo].[UpEtatCivil] ([CleEtatCivil], [Code], [EtatCivil]) VALUES (4, N'4', N'Veuf')
End
GO
SET IDENTITY_INSERT [dbo].[UpEtatCivil] OFF
GO
SET IDENTITY_INSERT [dbo].[UpProfile] ON 
GO
If Not Exists(select * from UpProfile where CleProfile=1)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (1, N'Empoyé')
End
GO
If Not Exists(select * from UpProfile where CleProfile=2)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (2, N'EmpAjouter')
End
GO
If Not Exists(select * from UpProfile where CleProfile=3)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (3, N'EmpMod')
End
GO
If Not Exists(select * from UpProfile where CleProfile=4)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (4, N'EmpSupp')
End
GO
If Not Exists(select * from UpProfile where CleProfile=5)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (5, N'EmpCacher')
End
GO
If Not Exists(select * from UpProfile where CleProfile=6)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (6, N'EmpAfficher')
End
GO
If Not Exists(select * from UpProfile where CleProfile=7)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (7, N'Paye')
End
GO
If Not Exists(select * from UpProfile where CleProfile=8)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (8, N'PayeAjouter')
End
GO
If Not Exists(select * from UpProfile where CleProfile=9)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (9, N'PayeMod')
End
GO
If Not Exists(select * from UpProfile where CleProfile=10)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (10, N'PaySupp')
End
GO
If Not Exists(select * from UpProfile where CleProfile=11)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (11, N'PayeCacher')
End
GO
If Not Exists(select * from UpProfile where CleProfile=12)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (12, N'PayeAfficher')
End
GO
If Not Exists(select * from UpProfile where CleProfile=13)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (13, N'PayeChargement')
End
GO
If Not Exists(select * from UpProfile where CleProfile=14)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (14, N'TableIRG')
End
GO
If Not Exists(select * from UpProfile where CleProfile=15)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (15, N'JournalPaye')
End
GO
If Not Exists(select * from UpProfile where CleProfile=16)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (16, N'JournalPayeDetail')
End
GO
If Not Exists(select * from UpProfile where CleProfile=17)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (17, N'Document')
End
GO
If Not Exists(select * from UpProfile where CleProfile=18)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (18, N'Attestation')
End
GO
If Not Exists(select * from UpProfile where CleProfile=19)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (19, N'Certificat')
End
GO
If Not Exists(select * from UpProfile where CleProfile=20)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (20, N'Contrat')
End
GO
If Not Exists(select * from UpProfile where CleProfile=21)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (21, N'PVInst')
End
GO
If Not Exists(select * from UpProfile where CleProfile=22)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (22, N'OrdreMission')
End
GO
If Not Exists(select * from UpProfile where CleProfile=23)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (23, N'TitreConge')
End
GO
If Not Exists(select * from UpProfile where CleProfile=24)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (24, N'FicheIndividuelle')
End
GO
If Not Exists(select * from UpProfile where CleProfile=25)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (25, N'DeclarationHoneur')
End
GO
If Not Exists(select * from UpProfile where CleProfile=26)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (26, N'Decision')
End
GO
If Not Exists(select * from UpProfile where CleProfile=27)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (27, N'ChangePoste')
End
GO
If Not Exists(select * from UpProfile where CleProfile=28)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (28, N'ChangeSalaire')
End
GO
If Not Exists(select * from UpProfile where CleProfile=29)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (29, N'Questionnaire')
End
GO
If Not Exists(select * from UpProfile where CleProfile=30)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (30, N'Avertissement')
End
GO
If Not Exists(select * from UpProfile where CleProfile=31)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (31, N'Blame')
End
GO
If Not Exists(select * from UpProfile where CleProfile=32)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (32, N'JournalDoc')
End
GO
If Not Exists(select * from UpProfile where CleProfile=33)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (33, N'DocCacher')
End
GO
If Not Exists(select * from UpProfile where CleProfile=34)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (34, N'DocAfficher')
End
GO
If Not Exists(select * from UpProfile where CleProfile=35)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (35, N'Fichier')
End
GO
If Not Exists(select * from UpProfile where CleProfile=36)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (36, N'GestionHorraire')
End
GO
If Not Exists(select * from UpProfile where CleProfile=37)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (37, N'TableauHorraire')
End
GO
If Not Exists(select * from UpProfile where CleProfile=38)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (38, N'Rubrique')
End
GO
If Not Exists(select * from UpProfile where CleProfile=39)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (39, N'Direction')
End
GO
If Not Exists(select * from UpProfile where CleProfile=40)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (40, N'Fonction')
End
GO
If Not Exists(select * from UpProfile where CleProfile=41)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (41, N'Grille')
End
GO
If Not Exists(select * from UpProfile where CleProfile=42)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (42, N'Position')
End
GO
If Not Exists(select * from UpProfile where CleProfile=43)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (43, N'Agence')
End
GO
If Not Exists(select * from UpProfile where CleProfile=44)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (44, N'Mode')
End
GO
If Not Exists(select * from UpProfile where CleProfile=45)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (45, N'SituationSN')
End
GO
If Not Exists(select * from UpProfile where CleProfile=46)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (46, N'TypeContrat')
End
GO
If Not Exists(select * from UpProfile where CleProfile=47)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (47, N'MotifDepart')
End
GO
If Not Exists(select * from UpProfile where CleProfile=48)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (48, N'Outil')
End
GO
If Not Exists(select * from UpProfile where CleProfile=49)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (49, N'Entreprise')
End
GO
If Not Exists(select * from UpProfile where CleProfile=50)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (50, N'Parametre')
End
GO
If Not Exists(select * from UpProfile where CleProfile=51)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (51, N'Securite')
End
GO
If Not Exists(select * from UpProfile where CleProfile=52)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (52, N'ModifMP')
End
GO
If Not Exists(select * from UpProfile where CleProfile=53)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (53, N'GestionBDD')
End
GO
If Not Exists(select * from UpProfile where CleProfile=54)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (54, N'DocMod')
End
GO
If Not Exists(select * from UpProfile where CleProfile=55)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (55, N'DocSupp')
End
GO
If Not Exists(select * from UpProfile where CleProfile=56)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (56, N'Exp')
End
GO
If Not Exists(select * from UpProfile where CleProfile=57)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (57, N'Imp')
End
GO
If Not Exists(select * from UpProfile where CleProfile=58)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (58, N'2pointage')
End
GO
If Not Exists(select * from UpProfile where CleProfile=59)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (59, N'2ajouterpointage')
End
GO
If Not Exists(select * from UpProfile where CleProfile=60)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (60, N'2supppointage')
End
GO
If Not Exists(select * from UpProfile where CleProfile=61)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (61, N'2chargerpointage')
End
GO
If Not Exists(select * from UpProfile where CleProfile=62)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (62, N'2syncpointage')
End
GO
If Not Exists(select * from UpProfile where CleProfile=63)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (63, N'2modifplaning')
End
GO
If Not Exists(select * from UpProfile where CleProfile=64)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (64, N'2modifpointage')
End
GO
If Not Exists(select * from UpProfile where CleProfile=65)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (65, N'2conge')
End
GO
If Not Exists(select * from UpProfile where CleProfile=66)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (66, N'2congeajouter')
End
GO
If Not Exists(select * from UpProfile where CleProfile=67)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (67, N'2congemodifier')
End
GO
If Not Exists(select * from UpProfile where CleProfile=68)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (68, N'2congesupp')
End
GO
If Not Exists(select * from UpProfile where CleProfile=69)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (69, N'2operation')
End
GO
If Not Exists(select * from UpProfile where CleProfile=70)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (70, N'2operationajouter')
End
GO
If Not Exists(select * from UpProfile where CleProfile=71)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (71, N'2operationmodifier')
End
GO
If Not Exists(select * from UpProfile where CleProfile=72)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (72, N'2operationsupp')
End
GO
If Not Exists(select * from UpProfile where CleProfile=73)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (73, N'2congecalculer')
End
GO
If Not Exists(select * from UpProfile where CleProfile=74)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (74, N'2cloturerpoint')
End
GO
If Not Exists(select * from UpProfile where CleProfile=75)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (75, N'2dessocierpoint')
End
GO
If Not Exists(select * from UpProfile where CleProfile=76)
Begin
INSERT [dbo].[UpProfile] ([CleProfile], [Profile]) VALUES (76, N'payeverr')
End
GO
SET IDENTITY_INSERT [dbo].[UpProfile] OFF
GO

/**************************************************************************************************************************/
/***********************************************************view***********************************************************/


/****** Object:  View [dbo].[EffetAll]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EffetAll]
AS
SELECT      dbo.Effet.CleEffet, dbo.Effet.CleTypeEffet, dbo.Effet.CleTiers, dbo.Effet.CleEntreprise, dbo.Effet.CleCategorieEffet, dbo.Effet.Reference, dbo.Effet.Date, dbo.Effet.Date2, dbo.Effet.MontantHT, 
                        dbo.Effet.RemisePourcent, dbo.Effet.Remise, dbo.Effet.TotalTVA, dbo.Effet.Timbre, dbo.Effet.MonantTTC, dbo.Effet.Payement, dbo.Effet.Associe, dbo.Effet.Cloture, dbo.Effet.RefAssocie, 
                        dbo.Effet.RefBC, dbo.Effet.CleUser, dbo.Effet.CleCommercial, dbo.Effet.CleMode, dbo.Effet.CleDepot, dbo.Effet.CleVehicule, dbo.Effet.CleVendeur, dbo.Effet.CreateDate, dbo.Effet.LastModifiedDate, 
                        dbo.Effet.CleUserModify, dbo.Effet.CleEtatEffet, dbo.Effet.TotalSHP, dbo.Effet.TotalPPA, dbo.Effet.CleTransaction, dbo.Effet.CleTVA, dbo.Effet.bCagnote, dbo.Effet.MontantCagnote, 
                        dbo.Effet.PayementCagnote, dbo.Effet.RemiseCagnote, dbo.Effet.RemisePourcent2, dbo.Effet.Remise2, dbo.Effet.bRemise, dbo.Effet.bRemise2, dbo.Effet.Invisible, dbo.Effet.MontantBrute, 
                        dbo.Effet.bPsycho, dbo.Effet.bControle, dbo.Effet.PayementRemise, dbo.Effet.PayementRemise2, dbo.Effet.PayementAssocie AS trs, dbo.Effet.bUseTauxRemise, dbo.Effet.RemiseApp, 
                        dbo.Effet.RemiseAvf,dbo.Effet.bUsePrimeCA,dbo.Effet.bUsePrimePayement, dbo.Effet.CleUserPayement
FROM          dbo.Effet
WHERE      (dbo.Effet.CleTypeEffet IN (5, 6, 7, 8))
UNION ALL
SELECT      dbo.EffetCharge.CleEffetCharge, dbo.EffetCharge.CleTypeEffetCharge, dbo.EffetCharge.CleTiers, dbo.EffetCharge.CleEntreprise, dbo.EffetCharge.CleCategorieCharge AS CleCategorieEffet, 
                        dbo.EffetCharge.Reference, dbo.EffetCharge.Date, dbo.EffetCharge.Date2, dbo.EffetCharge.MontantHT, dbo.EffetCharge.RemisePourcent, dbo.EffetCharge.Remise, dbo.EffetCharge.TotalTVA, 
                        dbo.EffetCharge.Timbre, dbo.EffetCharge.MonantTTC, dbo.EffetCharge.Payement, CAST(0 AS bit) AS Associe, dbo.EffetCharge.Cloture, '' AS RefAssocie, '' AS RefBC, dbo.EffetCharge.CleUser, 
                        0 AS CleCommercial, dbo.EffetCharge.CleMode, 0 AS CleDepot, 0 AS CleVehicule, 0 AS CleVendeur, dbo.EffetCharge.CreateDate, dbo.EffetCharge.LastModifiedDate, dbo.EffetCharge.CleUserModify, 
                        dbo.EffetCharge.CleEtatEffetCharge, 0 AS TotalSHP, 0 AS TotalPPA, 0 AS CleTransaction, dbo.EffetCharge.CleTVA, CAST(0 AS bit) AS bCagnote, 0 AS MontantCagnote, 0 AS PayementCagnote, 
                        0 AS RemiseCagnote, 0 AS RemisePourcent2, 0 AS Remise2, CAST(0 AS bit) AS bRemise, CAST(0 AS bit) AS bRemise2, dbo.EffetCharge.Invisible, dbo.EffetCharge.MontantHT AS MontantBrute, 
                        CAST(0 AS bit) AS bPsycho, CAST(0 AS bit) AS bControle, 0 AS PayementRemise, 0 AS PayementRemise2, dbo.EffetCharge.PayementAssocie AS trs, dbo.EffetCharge.bUseTauxRemise, 
                        0 AS RemiseApp, 0 AS RemiseAvf,dbo.EffetCharge.bUsePrimeCA,dbo.EffetCharge.bUsePrimePayement, 0 as cup
FROM          dbo.EffetCharge INNER JOIN
                        dbo.CategorieCharge ON dbo.EffetCharge.CleCategorieCharge = dbo.CategorieCharge.CleCategorieCharge
WHERE      (dbo.CategorieCharge.bUseJournal = 1)
GO
/****** Object:  View [dbo].[JournalEffetAll]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JournalEffetAll]
AS
SELECT      TOP (100) PERCENT dbo.EffetAll.CleEffet, dbo.EffetAll.CleTypeEffet, dbo.EffetAll.Reference, dbo.EffetAll.Date, dbo.EffetAll.Date2, dbo.Tiers.CodeTiers, dbo.Tiers.RaisonSociale, 
                        dbo.EffetAll.MontantHT AS Montant_HT, dbo.EffetAll.MonantTTC, dbo.Mode.Mode, dbo.EffetAll.Payement, dbo.EffetAll.MonantTTC - dbo.EffetAll.Payement AS Reste, dbo.EffetAll.Timbre, 
                        dbo.EffetAll.TotalTVA, dbo.EffetAll.TotalSHP, dbo.EffetAll.TotalPPA, dbo.EffetAll.Remise, dbo.EffetAll.RemisePourcent, CASE WHEN bRemise2 = 0 AND dbo.EffetAll.CleTypeEffet IN (6, 8) 
                        THEN CASE WHEN bRemise = 0 AND dbo.EffetAll.CleTypeEffet IN (6, 8) THEN dbo.EffetAll.MontantHT ELSE dbo.EffetAll.MontantHT + dbo.EffetAll.Remise END ELSE CASE WHEN bRemise = 0 AND 
                        dbo.EffetAll.CleTypeEffet IN (6, 8) THEN dbo.EffetAll.MontantHT ELSE dbo.EffetAll.MontantHT + dbo.EffetAll.Remise END + dbo.EffetAll.Remise2 END AS NetHT, dbo.CategorieEffet.CategorieEffet, 
                        User_1.Name, dbo.Depot.Depot, dbo.EtatEffet.EtatEffet, dbo.CategorieTiers.CategorieTiers, dbo.Vehicule.Vehicule, dbo.TypeTiers.TypeTiers, dbo.FamilleTiers.FamilleTiers, dbo.Region.Region, 
                        dbo.Wilaya.Wilaya, dbo.EffetAll.Associe, dbo.EffetAll.Cloture, dbo.EffetAll.CleEntreprise, dbo.EffetAll.CleTiers, dbo.EffetAll.CleCategorieEffet, dbo.EffetAll.CleUser, dbo.EffetAll.CleCommercial, 
                        dbo.EffetAll.CleMode, dbo.EffetAll.CleDepot, dbo.EffetAll.CleVehicule, dbo.EffetAll.CleVendeur, dbo.EffetAll.CleEtatEffet, dbo.Tiers.CleTypeTiers, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, 
                        dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, dbo.EffetAll.CleTransaction, dbo.CategorieEffet.Couleur, dbo.EtatEffet.Couleur AS CouleurEtat, dbo.EffetAll.MontantCagnote, 
                        dbo.EffetAll.PayementCagnote, dbo.EffetAll.MontantCagnote - dbo.EffetAll.PayementCagnote AS ResteCag, dbo.Tiers.CleUser AS CleUserAss, dbo.EffetAll.RemisePourcent2, dbo.EffetAll.Remise2, 
                        dbo.EffetAll.bRemise, dbo.EffetAll.bRemise2, dbo.EffetAll.Invisible, dbo.EffetAll.bCagnote, dbo.EffetAll.RefBC, dbo.EffetAll.RemiseCagnote, dbo.EffetAll.MontantBrute, User_3.Name AS Commercial, 
                        User_2.Name AS Vendeur, dbo.EffetAll.bPsycho, dbo.EffetAll.bControle, dbo.EffetAll.PayementRemise, dbo.EffetAll.PayementRemise2, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, 
                        dbo.EffetAll.trs, dbo.EffetAll.RemiseApp, dbo.EffetAll.RemiseAvf, dbo.Tiers.CleUserActuel
FROM          dbo.Depot RIGHT OUTER JOIN
                        dbo.EffetAll LEFT OUTER JOIN
                        dbo.[User] AS User_2 ON dbo.EffetAll.CleVendeur = User_2.CleUser LEFT OUTER JOIN
                        dbo.[User] AS User_3 ON dbo.EffetAll.CleCommercial = User_3.CleUser LEFT OUTER JOIN
                        dbo.Vehicule ON dbo.EffetAll.CleVehicule = dbo.Vehicule.CleVehicule LEFT OUTER JOIN
                        dbo.EtatEffet ON dbo.EffetAll.CleEtatEffet = dbo.EtatEffet.CleEtatEffet ON dbo.Depot.CleDepot = dbo.EffetAll.CleDepot LEFT OUTER JOIN
                        dbo.CategorieEffet ON dbo.EffetAll.CleCategorieEffet = dbo.CategorieEffet.CleCategorieEffet LEFT OUTER JOIN
                        dbo.Mode ON dbo.EffetAll.CleMode = dbo.Mode.CleMode LEFT OUTER JOIN
                        dbo.[User] AS User_1 ON dbo.EffetAll.CleUser = User_1.CleUser LEFT OUTER JOIN
                        dbo.TypeTiers RIGHT OUTER JOIN
                        dbo.Region RIGHT OUTER JOIN
                        dbo.Tiers LEFT OUTER JOIN
                        dbo.FamilleTiers ON dbo.Tiers.CleFamilleTiers = dbo.FamilleTiers.CleFamilleTiers LEFT OUTER JOIN
                        dbo.Wilaya ON dbo.Tiers.CleWilaya = dbo.Wilaya.CleWilaya ON dbo.Region.CleRegion = dbo.Tiers.CleRegion ON dbo.TypeTiers.CleTypeTiers = dbo.Tiers.CleTypeTiers LEFT OUTER JOIN
                        dbo.CategorieTiers ON dbo.Tiers.CleCategorieTiers = dbo.CategorieTiers.CleCategorieTiers ON dbo.EffetAll.CleTiers = dbo.Tiers.CleTiers
ORDER BY dbo.EffetAll.CleEffet DESC
GO
/****** Object:  View [dbo].[JVENTEAll]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JVENTEAll]
AS
SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT + 0 AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, 
                        TotalPPA, Commercial, Vendeur, CASE WHEN bRemise = 0 AND CleTypeEffet IN (6, 8) THEN 0 ELSE Remise END AS Remis, CASE WHEN bRemise = 0 AND CleTypeEffet IN (6, 8) 
                        THEN 0 ELSE RemisePourcent END AS RemisPourcent, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, 
                        CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, CleUserAss, Invisible, MontantBrute, CASE WHEN bRemise2 = 0 AND CleTypeEffet IN (6, 8) THEN 0 ELSE Remise2 END AS Remis2, 
                        CASE WHEN bRemise2 = 0 AND CleTypeEffet IN (6, 8) THEN 0 ELSE RemisePourcent2 END AS RemisPourcent2, bPsycho, bControle, CleStatutTiers, CleSolvabilite, trs, RemiseApp, RemiseAvf, 
                        CleUserActuel
FROM          dbo.JournalEffetAll
WHERE      (CleTypeEffet IN (6, 8, 1, 2)) AND (CleTypeTiers = 2)
ORDER BY CleEffet DESC
GO
/****** Object:  View [dbo].[__SCptBalance]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[__SCptBalance]
AS
SELECT DISTINCT dbo.DetailEcriture.SousCompte, dbo.SousCompte.NbCompte, dbo.SousCompte.Libelle
FROM          dbo.DetailEcriture INNER JOIN
                        dbo.SousCompte ON dbo.DetailEcriture.SousCompte = dbo.SousCompte.NbCompte
WHERE      (dbo.SousCompte.NbCompte LIKE '40%') OR
                        (dbo.SousCompte.NbCompte LIKE '41%')






GO
/****** Object:  View [dbo].[BALANCETIERS]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BALANCETIERS]
AS
SELECT      SousCompte, CONVERT(nvarchar(20), NbCompte) AS NCompte, Libelle, ODebit, OCredit, OSolde, EDebit, ECredit, ESolde, ODebit + EDebit AS TDebit, OCredit + ECredit AS TCredit, 
                        OSolde + ESolde AS TSolde
FROM          (SELECT      dbo.__SCptBalance.SousCompte, dbo.__SCptBalance.NbCompte, dbo.__SCptBalance.Libelle, CASE WHEN __OuvertureBalance.SommeDebit IS NULL 
                                                THEN 0 ELSE __OuvertureBalance.SommeDebit END AS ODebit, CASE WHEN __OuvertureBalance.SommeCredit IS NULL 
                                                THEN 0 ELSE __OuvertureBalance.SommeCredit END AS OCredit, CASE WHEN __OuvertureBalance.SommeSolde IS NULL 
                                                THEN 0 ELSE __OuvertureBalance.SommeSolde END AS OSolde, CASE WHEN __ExerciceBalance.SommeDebit2 IS NULL 
                                                THEN 0 ELSE __ExerciceBalance.SommeDebit2 END AS EDebit, CASE WHEN __ExerciceBalance.SommeCredit2 IS NULL 
                                                THEN 0 ELSE __ExerciceBalance.SommeCredit2 END AS ECredit, CASE WHEN __ExerciceBalance.SommeSolde2 IS NULL 
                                                THEN 0 ELSE __ExerciceBalance.SommeSolde2 END AS ESolde
                        FROM           dbo.__SCptBalance LEFT OUTER JOIN
                                                    (SELECT      dbo.DetailEcriture.SousCompte, SUM(dbo.DetailEcriture.Debit) AS SommeDebit2, SUM(dbo.DetailEcriture.Credit) AS SommeCredit2, SUM(dbo.DetailEcriture.Debit) 
                                                                              - SUM(dbo.DetailEcriture.Credit) AS SommeSolde2
                                                      FROM           dbo.DetailEcriture INNER JOIN
                                                                              dbo.Ecriture ON dbo.DetailEcriture.CleEcriture = dbo.Ecriture.CleEcriture
                                                      WHERE       (dbo.Ecriture.CleJournal <> 1) AND (dbo.Ecriture.Date >= '01-01-2015') AND (dbo.Ecriture.Date <= '31-12-2015')
                                                      GROUP BY dbo.DetailEcriture.SousCompte) AS __ExerciceBalance ON dbo.__SCptBalance.SousCompte = __ExerciceBalance.SousCompte LEFT OUTER JOIN
                                                    (SELECT      DetailEcriture_1.SousCompte, SUM(DetailEcriture_1.Debit) AS SommeDebit, SUM(DetailEcriture_1.Credit) AS SommeCredit, SUM(DetailEcriture_1.Debit) 
                                                                              - SUM(DetailEcriture_1.Credit) AS SommeSolde
                                                      FROM           dbo.DetailEcriture AS DetailEcriture_1 INNER JOIN
                                                                              dbo.Ecriture AS Ecriture_1 ON DetailEcriture_1.CleEcriture = Ecriture_1.CleEcriture
                                                      WHERE       (Ecriture_1.CleJournal = 1)
                                                      GROUP BY DetailEcriture_1.SousCompte) AS __OuvertureBalance ON dbo.__SCptBalance.SousCompte = __OuvertureBalance.SousCompte) AS balancestiers




GO
/****** Object:  View [dbo].[JournalEffet]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JournalEffet]
AS
SELECT      TOP (100) PERCENT dbo.Effet.CleEffet, dbo.Effet.CleTypeEffet, dbo.Effet.Reference, dbo.Effet.Date, dbo.Effet.Date2, dbo.Tiers.CodeTiers, dbo.Tiers.RaisonSociale, 
                        dbo.Effet.MontantHT AS Montant_HT, dbo.Effet.MonantTTC, dbo.Mode.Mode, dbo.Effet.Payement, dbo.Effet.MonantTTC - dbo.Effet.Payement AS Reste, dbo.Effet.Timbre, dbo.Effet.TotalTVA, 
                        dbo.Effet.TotalSHP, dbo.Effet.TotalPPA, dbo.Effet.Remise, dbo.Effet.RemisePourcent, CASE WHEN bRemise2 = 0 AND dbo.Effet.CleTypeEffet IN (6, 8, 10, 12) THEN CASE WHEN bRemise = 0 AND 
                        dbo.Effet.CleTypeEffet IN (6, 8, 10, 12) THEN dbo.Effet.MontantHT ELSE dbo.Effet.MontantHT + dbo.Effet.Remise END ELSE CASE WHEN bRemise = 0 AND dbo.Effet.CleTypeEffet IN (6, 8, 10, 12) 
                        THEN dbo.Effet.MontantHT ELSE dbo.Effet.MontantHT + dbo.Effet.Remise END + dbo.Effet.Remise2 END AS NetHT, dbo.CategorieEffet.CategorieEffet, User_1.Name, dbo.Depot.Depot, 
                        dbo.EtatEffet.EtatEffet, dbo.CategorieTiers.CategorieTiers, dbo.Vehicule.Vehicule, dbo.TypeTiers.TypeTiers, dbo.FamilleTiers.FamilleTiers, dbo.Region.Region, dbo.Wilaya.Wilaya, 
                        dbo.Effet.Associe, dbo.Effet.Cloture, dbo.Effet.CleEntreprise, dbo.Effet.CleTiers, dbo.Effet.CleCategorieEffet, dbo.Effet.CleUser, dbo.Effet.CleCommercial, dbo.Effet.CleMode, dbo.Effet.CleDepot, 
                        dbo.Effet.CleVehicule, dbo.Effet.CleVendeur, dbo.Effet.CleEtatEffet, dbo.Tiers.CleTypeTiers, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, 
                        dbo.Effet.CleTransaction, dbo.CategorieEffet.Couleur, dbo.EtatEffet.Couleur AS CouleurEtat, dbo.Effet.MontantCagnote, dbo.Effet.PayementCagnote, 
                        dbo.Effet.MontantCagnote - dbo.Effet.PayementCagnote AS ResteCag, dbo.Tiers.CleUser AS CleUserAss, dbo.Effet.RemisePourcent2, dbo.Effet.Remise2, dbo.Effet.bRemise, dbo.Effet.bRemise2, 
                        dbo.Effet.Invisible, dbo.Effet.bCagnote, dbo.Effet.RefBC, dbo.Effet.RemiseCagnote, dbo.Effet.MontantBrute, User_3.Name AS Commercial, User_2.Name AS Vendeur, 
                        CASE WHEN Doc.CleEffet IS NULL THEN 0 ELSE 1 END AS bDoc, CASE WHEN Compta.CleJour IS NULL THEN 0 ELSE 1 END AS bCompta, User_4.Name AS Préparateur, 
                        dbo.[User].Name AS Contrôleur, dbo.Effet.bPsycho, dbo.Effet.bControle, dbo.Effet.PayementRemise, dbo.Effet.PayementRemise2, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, 
                        CAST(dbo.Colis.NbColis AS nvarchar(5)) + ' Colis , ' + CAST(dbo.Colis.NbFrigo AS nvarchar(5)) + ' Frigo , ' + CAST(dbo.Colis.NbPsycho AS nvarchar(5)) + ' Psycho' AS colisa, dbo.Effet.RemiseApp, 
                        dbo.Effet.RemiseAvf, dbo.Effet.PayementRemiseAvf, dbo.Effet.CagnoteConsome, dbo.Tiers.CleUserActuel, dbo.Effet.Remise3
FROM          dbo.EtatEffet RIGHT OUTER JOIN
                        dbo.Effet LEFT OUTER JOIN
                        dbo.Colis ON dbo.Effet.CleEffet = dbo.Colis.CleEffet LEFT OUTER JOIN
                        dbo.[User] ON dbo.Effet.CleControleur = dbo.[User].CleUser LEFT OUTER JOIN
                        dbo.[User] AS User_4 ON dbo.Effet.ClePreparateur = User_4.CleUser LEFT OUTER JOIN
                        dbo.[User] AS User_2 ON dbo.Effet.CleVendeur = User_2.CleUser LEFT OUTER JOIN
                        dbo.[User] AS User_3 ON dbo.Effet.CleCommercial = User_3.CleUser LEFT OUTER JOIN
                        dbo.Vehicule ON dbo.Effet.CleVehicule = dbo.Vehicule.CleVehicule ON dbo.EtatEffet.CleEtatEffet = dbo.Effet.CleEtatEffet LEFT OUTER JOIN
                        dbo.Depot ON dbo.Effet.CleDepot = dbo.Depot.CleDepot LEFT OUTER JOIN
                        dbo.CategorieEffet ON dbo.Effet.CleCategorieEffet = dbo.CategorieEffet.CleCategorieEffet LEFT OUTER JOIN
                        dbo.Mode ON dbo.Effet.CleMode = dbo.Mode.CleMode LEFT OUTER JOIN
                        dbo.[User] AS User_1 ON dbo.Effet.CleUser = User_1.CleUser LEFT OUTER JOIN
                        dbo.TypeTiers RIGHT OUTER JOIN
                        dbo.Region RIGHT OUTER JOIN
                        dbo.Tiers LEFT OUTER JOIN
                        dbo.FamilleTiers ON dbo.Tiers.CleFamilleTiers = dbo.FamilleTiers.CleFamilleTiers LEFT OUTER JOIN
                        dbo.Wilaya ON dbo.Tiers.CleWilaya = dbo.Wilaya.CleWilaya ON dbo.Region.CleRegion = dbo.Tiers.CleRegion ON dbo.TypeTiers.CleTypeTiers = dbo.Tiers.CleTypeTiers LEFT OUTER JOIN
                        dbo.CategorieTiers ON dbo.Tiers.CleCategorieTiers = dbo.CategorieTiers.CleCategorieTiers ON dbo.Effet.CleTiers = dbo.Tiers.CleTiers LEFT OUTER JOIN
                            (SELECT      CleEffet
                              FROM           dbo.DocEffet
                              GROUP BY CleEffet) AS Doc ON dbo.Effet.CleEffet = Doc.CleEffet LEFT OUTER JOIN
                            (SELECT      CleJour
                              FROM           dbo.Ecriture
                              WHERE       (Jour IN (1, 2))
                              GROUP BY CleJour) AS Compta ON dbo.Effet.CleEffet = Compta.CleJour
ORDER BY dbo.Effet.CleEffet DESC
GO
/****** Object:  View [dbo].[JCAGNOTEX2]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JCAGNOTEX2]
AS
SELECT      CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT, MonantTTC, Mode, Payement, Rest + 0 AS Reste, Timbre, TotalTVA, TotalSHP, TotalPPA, Commercial, 
                        Vendeur, Remis, RemisPourcent + 0 AS RemisePourcent, RemisPourcent2 + 0 AS RemisePourcent2, Remis2, bRemise, bRemise2, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, 
                        Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, 
                        CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, MonUG AS MontantCagnote, PayementCagno AS PayementCagnote, CleUserAss, 
                        bCagnote, CONVERT(DECIMAL(10, 2), MonUG * (RemiseCagnote / 100.00)) + CONVERT(DECIMAL(10, 2), (Remis + Remis3) * (RemiseCagnote / 100.00)) + CONVERT(DECIMAL(10, 2), 
                        Remis2 * (RemiseCagnote / 100.00)) AS TAP, CONVERT(DECIMAL(10, 2), MonUG * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), (Remis + Remis3) 
                        * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), Remis2 * (1 - RemiseCagnote / 100.00) + 0.000001) AS NetCagnotte, CONVERT(DECIMAL(10, 2), 
                        MonUG * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), (Remis + Remis3) * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), 
                        Remis2 * (1 - RemiseCagnote / 100.00) + 0.000001) - PayementCagno AS ResteCagnote, RemiseCagnote, PayementUG, PayementRemise, PayementRemise2, CleStatutTiers, CleSolvabilite, 
                        CleUserActuel, Remis + Remis3 AS Remis13, Remis3
FROM          (SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT, MonantTTC, Mode, Payement, MonantTTC - Payement AS Rest, Timbre, 
                                                TotalTVA, TotalSHP, TotalPPA, Commercial, Vendeur, CASE WHEN JournalEffet.bRemise = 0 THEN CONVERT(DECIMAL(10, 2), JournalEffet.Remise) ELSE 0 END AS Remis, 
                                                CASE WHEN JournalEffet.bRemise = 0 THEN JournalEffet.RemisePourcent ELSE 0 END AS RemisPourcent, 
                                                CASE WHEN JournalEffet.bRemise2 = 0 THEN JournalEffet.RemisePourcent2 ELSE 0 END AS RemisPourcent2, CASE WHEN JournalEffet.bRemise2 = 0 THEN CONVERT(DECIMAL(10, 2), 
                                                JournalEffet.Remise2) ELSE 0 END AS Remis2, bRemise, bRemise2, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, 
                                                Associe, Cloture, CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, 
                                                CleWilaya, CleRegion, CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, CASE WHEN JournalEffet.bCagnote = 0 THEN CONVERT(DECIMAL(10, 2), 
                                                dbo.JournalEffet.MontantCagnote) ELSE 0 END AS MonUG, PayementCagnote + PayementRemise + PayementRemise2 AS PayementCagno, CleUserAss, bCagnote, RemiseCagnote, 
                                                PayementCagnote AS PayementUG, PayementRemise, PayementRemise2, CleStatutTiers, CleSolvabilite, CleUserActuel, CONVERT(DECIMAL(10, 2), Remise3) AS Remis3
                        FROM           dbo.JournalEffet
                        WHERE       (CleTypeEffet IN (10, 12)) AND (Reference IS NOT NULL)
                        ORDER BY CleEffet DESC) AS JournalCagnote
GO
/****** Object:  View [dbo].[JCAGNOTE2]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JCAGNOTE2]
AS
SELECT      CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, TotalPPA, Commercial, 
                        Vendeur, Remis, RemisePourcent, RemisePourcent2, Remis2, bRemise, bRemise2, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, 
                        Wilaya, Associe, Cloture, CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, 
                        CleRegion, CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, MontantCagnote, PayementCagnote, CleUserAss, bCagnote, TAP, NetCagnotte, ResteCagnote, RemiseCagnote, PayementUG, 
                        PayementRemise, PayementRemise2, CleStatutTiers, CleSolvabilite, CleUserActuel, Remis13, Remis3
FROM          dbo.JCAGNOTEX2
WHERE      (NetCagnotte > 0)
GO
/****** Object:  View [dbo].[JGCagnotte]    Script Date: 31/01/2024 14:13:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[JGCagnotte]
AS
SELECT      CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, MontantHT, MonantTTC, Mode, Payement, Rest + 0 AS Reste, Timbre, TotalTVA, TotalSHP, TotalPPA, Commercial, Vendeur, 
                        Remis, CONVERT(DECIMAL(10, 2), CASE WHEN MontantHT - MonUG = 0 THEN 0 ELSE (Remis / (MontantHT - MonUG)) * 100 + 0 END) AS RemisePourcent, RemisPourcent2 + 0 AS RemisePourcent2,
                         Remis2, bRemise, bRemise2, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, CleEntreprise, CleTiers, 
                        CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, CleCategorieTiers, CleTransaction, 
                        Couleur, CouleurEtat, MonUG AS MontantCagnote, PayementCagno AS PayementCagnote, CleUserAss, bCagnote, CONVERT(DECIMAL(10, 2), MonUG * (RemiseCagnote / 100.00)) 
                        + CONVERT(DECIMAL(10, 2), Remis * (RemiseCagnote / 100.00)) + CONVERT(DECIMAL(10, 2), Remis2 * (RemiseCagnote / 100.00)) AS TAP, CONVERT(DECIMAL(10, 2), 
                        MonUG * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), Remis * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), 
                        Remis2 * (1 - RemiseCagnote / 100.00) + 0.000001) AS NetCagnotte, CONVERT(DECIMAL(10, 2), MonUG * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), 
                        Remis * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), Remis2 * (1 - RemiseCagnote / 100.00) + 0.000001) - PayementCagno AS ResteCagnote, RemiseCagnote, 
                        PayementUG, PayementRemise, PayementRemise2, CleStatutTiers, CleSolvabilite, CleUserActuel
FROM          (SELECT      JournalEffet_1.CleEffet, JournalEffet_1.CleTypeEffet, Eff.Reference, Eff.Date, JournalEffet_1.Date2, JournalEffet_1.CodeTiers, JournalEffet_1.RaisonSociale, Eff.MontantHT, 
                                                Eff.MonantTTC, JournalEffet_1.Mode, Eff.Payement, Eff.MonantTTC - Eff.Payement AS Rest, JournalEffet_1.Timbre, JournalEffet_1.TotalTVA, JournalEffet_1.TotalSHP, 
                                                JournalEffet_1.TotalPPA, JournalEffet_1.Commercial, JournalEffet_1.Vendeur, CASE WHEN JournalEffet_1.bRemise = 0 THEN CONVERT(DECIMAL(10, 2), 
                                                JournalEffet_1.Remise + JournalEffet_1.Remise3) ELSE 0 END AS Remis, CASE WHEN JournalEffet_1.bRemise = 0 THEN JournalEffet_1.RemisePourcent ELSE 0 END AS RemisPourcent,
                                                 CASE WHEN JournalEffet_1.bRemise2 = 0 THEN CONVERT(DECIMAL(10, 2), 
                                                CASE WHEN Trans.Remise > 0 THEN Trans.Remise * 100.00 / JournalEffet_1.MonantTTC ELSE JournalEffet_1.RemisePourcent2 END) ELSE 0 END AS RemisPourcent2, 
                                                CASE WHEN JournalEffet_1.bRemise2 = 0 THEN CONVERT(DECIMAL(10, 2), CASE WHEN Trans.Remise > 0 THEN Trans.remise ELSE JournalEffet_1.Remise2 END) 
                                                ELSE 0 END AS Remis2, JournalEffet_1.bRemise, JournalEffet_1.bRemise2, JournalEffet_1.NetHT, JournalEffet_1.CategorieEffet, JournalEffet_1.Name, JournalEffet_1.Depot, 
                                                JournalEffet_1.EtatEffet, JournalEffet_1.CategorieTiers, JournalEffet_1.Vehicule, JournalEffet_1.TypeTiers, JournalEffet_1.FamilleTiers, JournalEffet_1.Region, JournalEffet_1.Wilaya, 
                                                JournalEffet_1.Associe, JournalEffet_1.Cloture, JournalEffet_1.CleEntreprise, JournalEffet_1.CleTiers, JournalEffet_1.CleCategorieEffet, JournalEffet_1.CleUser, 
                                                JournalEffet_1.CleCommercial, JournalEffet_1.CleMode, JournalEffet_1.CleDepot, JournalEffet_1.CleVehicule, JournalEffet_1.CleVendeur, JournalEffet_1.CleEtatEffet, 
                                                JournalEffet_1.CleTypeTiers, JournalEffet_1.CleFamilleTiers, JournalEffet_1.CleWilaya, JournalEffet_1.CleRegion, JournalEffet_1.CleCategorieTiers, JournalEffet_1.CleTransaction, 
                                                JournalEffet_1.Couleur, JournalEffet_1.CouleurEtat, CASE WHEN JournalEffet_1.bCagnote = 0 THEN CONVERT(DECIMAL(10, 2), JournalEffet_1.MontantCagnote) ELSE 0 END AS MonUG, 
                                                JournalEffet_1.PayementCagnote + JournalEffet_1.PayementRemise + JournalEffet_1.PayementRemise2 AS PayementCagno, JournalEffet_1.CleUserAss, JournalEffet_1.bCagnote, 
                                                JournalEffet_1.RemiseCagnote, JournalEffet_1.PayementCagnote AS PayementUG, JournalEffet_1.PayementRemise, JournalEffet_1.PayementRemise2, JournalEffet_1.CleStatutTiers, 
                                                JournalEffet_1.CleSolvabilite, JournalEffet_1.CleUserActuel
                        FROM           dbo.JournalEffet AS JournalEffet_1 INNER JOIN
                                                    (SELECT      CleEffet, Reference, Date, MontantHT, MonantTTC, Payement
                                                      FROM           dbo.Effet
                                                      WHERE       (CleTypeEffet IN (6, 8))) AS Eff ON JournalEffet_1.RefBC = Eff.Reference LEFT OUTER JOIN
                                                    (SELECT      dbo.DetailTrans.CleEffet, SUM(dbo.DetailTrans.Tranche) AS pay, 
                                                                              SUM(dbo.DetailTrans.Tranche * CASE WHEN dbo.DetailTrans.bRemise2 = 1 THEN dbo.Transact.RemisePourcent ELSE 0 END / 100.00) AS remise
                                                      FROM           dbo.DetailTrans INNER JOIN
                                                                              dbo.Transact ON dbo.DetailTrans.CleTransaction = dbo.Transact.CleTransact
                                                      GROUP BY dbo.DetailTrans.CleEffet) AS Trans ON Eff.CleEffet = Trans.CleEffet
                        WHERE       (JournalEffet_1.CleTypeEffet IN (10, 12)) AND (Eff.Reference IS NOT NULL)
                        UNION ALL
                        SELECT      journaleffet.CleEffet, journaleffet.CleTypeEffet, journaleffet.Reference, journaleffet.Date, journaleffet.Date2, journaleffet.CodeTiers, journaleffet.RaisonSociale, journaleffet.Montant_HT, 
                                                journaleffet.MonantTTC, journaleffet.Mode, journaleffet.Payement, journaleffet.MonantTTC - journaleffet.Payement AS Rest, journaleffet.Timbre, journaleffet.TotalTVA, 
                                                journaleffet.TotalSHP, journaleffet.TotalPPA, journaleffet.Commercial, journaleffet.Vendeur, CASE WHEN JournalEffet.bRemise = 0 THEN CONVERT(DECIMAL(10, 2), 
                                                JournalEffet.Remise + JournalEffet.Remise3) ELSE 0 END AS Remis, CASE WHEN JournalEffet.bRemise = 0 THEN JournalEffet.RemisePourcent ELSE 0 END AS RemisPourcent, 
                                                CASE WHEN JournalEffet.bRemise2 = 0 THEN CONVERT(DECIMAL(10, 2), 
                                                CASE WHEN Trans_1.Remise > 0 THEN Trans_1.Remise * 100.00 / JournalEffet.MonantTTC ELSE JournalEffet.RemisePourcent2 END) ELSE 0 END AS RemisPourcent2, 
                                                CASE WHEN JournalEffet.bRemise2 = 0 THEN CONVERT(DECIMAL(10, 2), CASE WHEN Trans_1.Remise > 0 THEN Trans_1.remise ELSE JournalEffet.Remise2 END) 
                                                ELSE 0 END AS Remis2, journaleffet.bRemise, journaleffet.bRemise2, journaleffet.NetHT, journaleffet.CategorieEffet, journaleffet.Name, journaleffet.Depot, journaleffet.EtatEffet, 
                                                journaleffet.CategorieTiers, journaleffet.Vehicule, journaleffet.TypeTiers, journaleffet.FamilleTiers, journaleffet.Region, journaleffet.Wilaya, journaleffet.Associe, journaleffet.Cloture, 
                                                journaleffet.CleEntreprise, journaleffet.CleTiers, journaleffet.CleCategorieEffet, journaleffet.CleUser, journaleffet.CleCommercial, journaleffet.CleMode, journaleffet.CleDepot, 
                                                journaleffet.CleVehicule, journaleffet.CleVendeur, journaleffet.CleEtatEffet, journaleffet.CleTypeTiers, journaleffet.CleFamilleTiers, journaleffet.CleWilaya, journaleffet.CleRegion, 
                                                journaleffet.CleCategorieTiers, journaleffet.CleTransaction, journaleffet.Couleur, journaleffet.CouleurEtat, CASE WHEN JournalEffet.bCagnote = 0 THEN CONVERT(DECIMAL(10, 2), 
                                                JournalEffet.MontantCagnote) ELSE 0 END AS MonUG, journaleffet.PayementCagnote + journaleffet.PayementRemise + journaleffet.PayementRemise2 AS PayementCagno, 
                                                journaleffet.CleUserAss, journaleffet.bCagnote, journaleffet.RemiseCagnote, journaleffet.PayementCagnote AS PayementUG, journaleffet.PayementRemise, 
                                                journaleffet.PayementRemise2, journaleffet.CleStatutTiers, journaleffet.CleSolvabilite, journaleffet.CleUserActuel
                        FROM          (SELECT      TOP (100) PERCENT EffetAll.CleEffet, EffetAll.CleTypeEffet, EffetAll.Reference, EffetAll.Date, EffetAll.Date2, dbo.Tiers.CodeTiers, dbo.Tiers.RaisonSociale, 
                                                                        CASE WHEN effetall.bRemise2 = 1 THEN effetall.MontantHT - effetall.Remise2 ELSE effetall.MontantHT END AS Montant_HT, EffetAll.MonantTTC, dbo.Mode.Mode, 
                                                                        EffetAll.Payement, EffetAll.MonantTTC - EffetAll.Payement AS Reste, EffetAll.Timbre, EffetAll.TotalTVA, EffetAll.TotalSHP, EffetAll.TotalPPA, EffetAll.Remise, 
                                                                        EffetAll.RemisePourcent, CASE WHEN bRemise = 0 AND effetall.CleTypeEffet IN (6, 8) THEN effetall.MontantHT ELSE effetall.MontantHT + effetall.Remise END AS NetHT, 
                                                                        dbo.CategorieEffet.CategorieEffet, User_1.Name, dbo.Depot.Depot, dbo.EtatEffet.EtatEffet, dbo.CategorieTiers.CategorieTiers, dbo.Vehicule.Vehicule, dbo.TypeTiers.TypeTiers, 
                                                                        dbo.FamilleTiers.FamilleTiers, dbo.Region.Region, dbo.Wilaya.Wilaya, EffetAll.Associe, EffetAll.Cloture, EffetAll.CleEntreprise, EffetAll.CleTiers, EffetAll.CleCategorieEffet, 
                                                                        EffetAll.CleUser, EffetAll.CleCommercial, EffetAll.CleMode, EffetAll.CleDepot, EffetAll.CleVehicule, EffetAll.CleVendeur, EffetAll.CleEtatEffet, dbo.Tiers.CleTypeTiers, 
                                                                        dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, EffetAll.CleTransaction, dbo.CategorieEffet.Couleur, 
                                                                        dbo.EtatEffet.Couleur AS CouleurEtat, EffetAll.MontantCagnote, EffetAll.PayementCagnote, EffetAll.MontantCagnote - EffetAll.PayementCagnote AS ResteCag, 
                                                                        dbo.Tiers.CleUser AS CleUserAss, EffetAll.RemisePourcent2, EffetAll.Remise2, EffetAll.bRemise, EffetAll.bRemise2, EffetAll.Invisible, EffetAll.bCagnote, EffetAll.RefBC, 
                                                                        EffetAll.RemiseCagnote, EffetAll.MontantBrute, User_3.Name AS Commercial, User_2.Name AS Vendeur, EffetAll.bPsycho, EffetAll.bControle, EffetAll.PayementRemise, 
                                                                        EffetAll.PayementRemise2, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, EffetAll.trs, EffetAll.RemiseApp, EffetAll.RemiseAvf, dbo.Tiers.CleUserActuel, 
                                                                        EffetAll.Remise3
                                                FROM           dbo.Depot RIGHT OUTER JOIN
                                                                            (SELECT      CleEffet, CleTypeEffet, CleTiers, CleEntreprise, CleCategorieEffet, Reference, Date, Date2, MontantHT, RemisePourcent, Remise, TotalTVA, Timbre, MonantTTC, 
                                                                                                      Payement, Associe, Cloture, RefAssocie, RefBC, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CreateDate, LastModifiedDate, 
                                                                                                      CleUserModify, CleEtatEffet, TotalSHP, TotalPPA, CleTransaction, CleTVA, bCagnote, MontantCagnote, PayementCagnote, RemiseCagnote, RemisePourcent2, 
                                                                                                      Remise2, bRemise, bRemise2, Invisible, MontantBrute, bPsycho, bControle, PayementRemise, PayementRemise2, PayementAssocie AS trs, bUseTauxRemise, 
                                                                                                      RemiseApp, RemiseAvf, Remise3
                                                                              FROM           dbo.Effet AS Effet_1
                                                                              WHERE       (CleTypeEffet IN (30))
                                                                              UNION ALL
                                                                              SELECT      dbo.EffetCharge.CleEffetCharge, dbo.EffetCharge.CleTypeEffetCharge, dbo.EffetCharge.CleTiers, dbo.EffetCharge.CleEntreprise, 
                                                                                                      dbo.EffetCharge.CleCategorieCharge AS CleCategorieEffet, dbo.EffetCharge.Reference, dbo.EffetCharge.Date, dbo.EffetCharge.Date2, dbo.EffetCharge.MontantHT,
                                                                                                       dbo.EffetCharge.RemisePourcent, dbo.EffetCharge.Remise, dbo.EffetCharge.TotalTVA, dbo.EffetCharge.Timbre, dbo.EffetCharge.MonantTTC, 
                                                                                                      dbo.EffetCharge.Payement, CAST(0 AS bit) AS Associe, dbo.EffetCharge.Cloture, '' AS RefAssocie, '' AS RefBC, dbo.EffetCharge.CleUser, 0 AS CleCommercial, 
                                                                                                      dbo.EffetCharge.CleMode, 0 AS CleDepot, 0 AS CleVehicule, 0 AS CleVendeur, dbo.EffetCharge.CreateDate, dbo.EffetCharge.LastModifiedDate, 
                                                                                                      dbo.EffetCharge.CleUserModify, dbo.EffetCharge.CleEtatEffetCharge, 0 AS TotalSHP, 0 AS TotalPPA, 0 AS CleTransaction, dbo.EffetCharge.CleTVA, CAST(0 AS bit) 
                                                                                                      AS bCagnote, 0 AS MontantCagnote, 0 AS PayementCagnote, 0 AS RemiseCagnote, 0 AS RemisePourcent2, 0 AS Remise2, CAST(0 AS bit) AS bRemise, 
                                                                                                      CAST(0 AS bit) AS bRemise2, dbo.EffetCharge.Invisible, dbo.EffetCharge.MontantHT AS MontantBrute, CAST(0 AS bit) AS bPsycho, CAST(0 AS bit) AS bControle, 
                                                                                                      0 AS PayementRemise, 0 AS PayementRemise2, dbo.EffetCharge.PayementAssocie AS trs, dbo.EffetCharge.bUseTauxRemise, 0 AS RemiseApp, 
                                                                                                      0 AS RemiseAvf, 0 AS Remise3
                                                                              FROM          dbo.EffetCharge INNER JOIN
                                                                                                      dbo.CategorieCharge ON dbo.EffetCharge.CleCategorieCharge = dbo.CategorieCharge.CleCategorieCharge
                                                                              WHERE      (dbo.CategorieCharge.bUseJournal = 1)) AS EffetAll LEFT OUTER JOIN
                                                                        dbo.[User] AS User_2 ON EffetAll.CleVendeur = User_2.CleUser LEFT OUTER JOIN
                                                                        dbo.[User] AS User_3 ON EffetAll.CleCommercial = User_3.CleUser LEFT OUTER JOIN
                                                                        dbo.Vehicule ON EffetAll.CleVehicule = dbo.Vehicule.CleVehicule LEFT OUTER JOIN
                                                                        dbo.EtatEffet ON EffetAll.CleEtatEffet = dbo.EtatEffet.CleEtatEffet ON dbo.Depot.CleDepot = EffetAll.CleDepot LEFT OUTER JOIN
                                                                        dbo.CategorieEffet ON EffetAll.CleCategorieEffet = dbo.CategorieEffet.CleCategorieEffet LEFT OUTER JOIN
                                                                        dbo.Mode ON EffetAll.CleMode = dbo.Mode.CleMode LEFT OUTER JOIN
                                                                        dbo.[User] AS User_1 ON EffetAll.CleUser = User_1.CleUser LEFT OUTER JOIN
                                                                        dbo.TypeTiers RIGHT OUTER JOIN
                                                                        dbo.Region RIGHT OUTER JOIN
                                                                        dbo.Tiers LEFT OUTER JOIN
                                                                        dbo.FamilleTiers ON dbo.Tiers.CleFamilleTiers = dbo.FamilleTiers.CleFamilleTiers LEFT OUTER JOIN
                                                                        dbo.Wilaya ON dbo.Tiers.CleWilaya = dbo.Wilaya.CleWilaya ON dbo.Region.CleRegion = dbo.Tiers.CleRegion ON 
                                                                        dbo.TypeTiers.CleTypeTiers = dbo.Tiers.CleTypeTiers LEFT OUTER JOIN
                                                                        dbo.CategorieTiers ON dbo.Tiers.CleCategorieTiers = dbo.CategorieTiers.CleCategorieTiers ON EffetAll.CleTiers = dbo.Tiers.CleTiers
                                                ORDER BY EffetAll.CleEffet DESC) AS journaleffet LEFT OUTER JOIN
                                                    (SELECT      DetailTrans_1.CleEffetCharge, SUM(DetailTrans_1.Tranche) AS pay, SUM(DetailTrans_1.Tranche * Transact_1.RemisePourcent / 100.00) AS remise
                                                      FROM           dbo.DetailTrans AS DetailTrans_1 INNER JOIN
                                                                              dbo.Transact AS Transact_1 ON DetailTrans_1.CleTransaction = Transact_1.CleTransact
                                                      GROUP BY DetailTrans_1.CleEffetCharge) AS Trans_1 ON journaleffet.CleEffet = Trans_1.CleEffetCharge
                        WHERE      (CASE WHEN JournalEffet.bRemise2 = 0 THEN CONVERT(DECIMAL(10, 2), CASE WHEN Trans_1.Remise > 0 THEN Trans_1.remise ELSE JournalEffet.Remise2 END) ELSE 0 END > 0)) 
                        AS journalcagnote
WHERE      (CONVERT(DECIMAL(10, 2), MonUG * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), Remis * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), 
                        Remis2 * (1 - RemiseCagnote / 100.00) + 0.000001) > 0)
GO
/****** Object:  View [dbo].[JACHATAll]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JACHATAll]
AS
SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT + 0 AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, 
                        TotalPPA, Commercial, Vendeur, Remise, RemisePourcent, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, 
                        CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, CleUserAss, Invisible, MontantBrute, RemisePourcent2, Remise2, bPsycho, bControle, CleStatutTiers, CleSolvabilite, trs, 
                        CleUserActuel
FROM          dbo.JournalEffetAll
WHERE      (CleTypeEffet IN (5, 7, 2, 1)) AND (CleTypeTiers = 1)
ORDER BY CleEffet DESC
GO
/****** Object:  View [dbo].[JLot]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JLot]
AS
SELECT      TOP (100) PERCENT dbo.Produit.CleProduit, dbo.Lot.CleLot, dbo.Produit.Code, dbo.Produit.Reference, dbo.Produit.Designation, dbo.Lot.NLot, dbo.Lot.CodeLot, dbo.Lot.DateExp, 
                        dbo.Lot.Quantite AS Qtite, dbo.Lot.PrixAchat, dbo.Lot.PrixVente, dbo.Lot.Marge, dbo.Marque.Marque, dbo.Lot.Colisage, dbo.Lot.Coeff, dbo.Lot.MaxUG, dbo.Lot.MaxUG2, dbo.StatutLot.StatutLot, 
                        dbo.Lot.PrixVente - dbo.Lot.PrixAchat AS MargeG, dbo.Lot.MargePh, dbo.Lot.PPA - dbo.Lot.PrixVente AS MargeC, dbo.Lot.PPA, dbo.Lot.SHP, dbo.Lot.Remise, dbo.Taxe.Valeur, dbo.Produit.TR, 
                        dbo.Emplacement.Emplacement, dbo.Produit.bBloque, dbo.Lot.bBloque AS bBloque2, dbo.FamilleArticle.FamilleArticle, dbo.CategorieProduit.CategorieProduit, dbo.CategorieProduit.Couleur, 
                        dbo.Produit.CleDCI, dbo.Produit.Invisible, dbo.Lot.Invisible AS Invisible2, dbo.Lot.MaxUG3, dbo.Produit.CleTVA, dbo.Produit.CleFamilleArticle, dbo.Produit.CleCategorieProduit, 
                        dbo.Produit.bPerimable, dbo.Lot.CleEmplacement, dbo.Lot.CleStatutLot, dbo.Lot.CleMarque
FROM          dbo.Produit INNER JOIN
                        dbo.Lot ON dbo.Produit.CleProduit = dbo.Lot.CleProduit LEFT OUTER JOIN
                        dbo.Marque ON dbo.Lot.CleMarque = dbo.Marque.CleMarque LEFT OUTER JOIN
                        dbo.StatutLot ON dbo.Lot.CleStatutLot = dbo.StatutLot.CleStatutLot LEFT OUTER JOIN
                        dbo.Emplacement ON dbo.Lot.CleEmplacement = dbo.Emplacement.CleEmplacement LEFT OUTER JOIN
                        dbo.FamilleArticle ON dbo.Produit.CleFamilleArticle = dbo.FamilleArticle.CleFamilleArticle LEFT OUTER JOIN
                        dbo.CategorieProduit ON dbo.Produit.CleCategorieProduit = dbo.CategorieProduit.CleCategorieProduit LEFT OUTER JOIN
                        dbo.Taxe ON dbo.Produit.CleTVA = dbo.Taxe.CleTaxe



GO
/****** Object:  View [dbo].[ProductionJournal]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductionJournal]
AS
SELECT      dbo.Production.CleProduction, dbo.Production.Reference, dbo.Production.Date, dbo.Production.Libelle, dbo.Production.Debut, dbo.Production.Fin, dbo.Production.TotalProduit, 
                        dbo.Production.Montant, Effet_1.Reference AS BE, dbo.Effet.Reference AS BS, dbo.JLot.CleProduit, dbo.JLot.CleLot, dbo.JLot.Code, dbo.JLot.Reference AS RefProduit, dbo.JLot.Designation, 
                        dbo.JLot.NLot, dbo.JLot.DateExp, dbo.JLot.Qtite AS QuantiteDisponible, dbo.JLot.Marque, dbo.JLot.StatutLot, dbo.JLot.Emplacement, dbo.JLot.CategorieProduit, dbo.JLot.FamilleArticle, 
                        dbo.JLot.CleFamilleArticle, dbo.JLot.CleTVA, dbo.JLot.CleCategorieProduit, dbo.JLot.CleEmplacement, dbo.JLot.CleStatutLot, dbo.JLot.CleMarque, dbo.JLot.bPerimable, dbo.Production.CleBE, 
                        dbo.Production.CleBS, dbo.Production.bFinished, dbo.Production.Locked, dbo.UniteProduction.CleDepotEntree, dbo.UniteProduction.CleDepotSortie, CASE WHEN Doc.CleProduction IS NULL 
                        THEN 0 ELSE 1 END AS bDoc
FROM          dbo.Effet AS Effet_1 RIGHT OUTER JOIN
                        dbo.JLot RIGHT OUTER JOIN
                        dbo.UniteProduction RIGHT OUTER JOIN
                        dbo.Production ON dbo.UniteProduction.CleUniteProduction = dbo.Production.CleUnite ON dbo.JLot.CleLot = dbo.Production.CleLot LEFT OUTER JOIN
                        dbo.Effet ON dbo.Production.CleBS = dbo.Effet.CleEffet ON Effet_1.CleEffet = dbo.Production.CleBE LEFT OUTER JOIN
                            (SELECT      CleProduction
                              FROM           dbo.DocProduction
                              GROUP BY CleProduction) AS Doc ON dbo.Production.CleProduction = Doc.CleProduction



GO
/****** Object:  View [dbo].[RealisationConvention]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RealisationConvention]
AS
SELECT      Conv.CleConvention, Achat.CleTiers, Achat.CleProduit, SUM(Achat.ca) AS Montant, Conv.Gamme
FROM          (SELECT      dbo.Effet.CleTiers, dbo.Produit.CleProduit, CASE WHEN CleTypeEffet IN (9, 10) THEN (DetailEffet.Quantite * DetailEffet.PrixUnitaireHT * (1 - (DetailEffet.RistournePourcent / 100.00)) 
                                                - dbo.DetailEffet.Cagnote) * (1 - (Effet.RemisePourcent / 100.00)) WHEN CleTypeEffet IN (11, 12) 
                                                THEN - ((DetailEffet.Quantite * DetailEffet.PrixUnitaireHT * (1 - (DetailEffet.RistournePourcent / 100.00)) - dbo.DetailEffet.Cagnote) * (1 - (Effet.RemisePourcent / 100.00))) ELSE 0 END AS ca,
                                                 dbo.Effet.Date
                        FROM           dbo.Effet INNER JOIN
                                                dbo.DetailEffet ON dbo.Effet.CleEffet = dbo.DetailEffet.CleEffet INNER JOIN
                                                dbo.Lot ON dbo.DetailEffet.CleLot = dbo.Lot.CleLot INNER JOIN
                                                dbo.Produit ON dbo.Lot.CleProduit = dbo.Produit.CleProduit
                        WHERE       (dbo.Effet.CleTypeEffet IN (9, 10, 11, 12)) AND (dbo.Effet.Associe = 1)) AS Achat INNER JOIN
                            (SELECT      dbo.Convention.CleConvention, dbo.Convention.CleTiers, dbo.Convention.Debut, dbo.Convention.Fin, dbo.DetailConvention.CleProduit, dbo.DetailConvention.Gamme
                              FROM           dbo.Convention INNER JOIN
                                                      dbo.DetailConvention ON dbo.Convention.CleConvention = dbo.DetailConvention.CleConvention
                              WHERE       (dbo.Convention.Suivi = 1) AND (dbo.Convention.bVente = 0) AND (dbo.Convention.bLabo = 0)) AS Conv ON Conv.CleProduit = Achat.CleProduit AND 
                        Achat.CleTiers = Conv.CleTiers
WHERE      (Achat.Date BETWEEN Conv.Debut AND Conv.Fin)
GROUP BY Achat.CleTiers, Achat.CleProduit, Conv.CleConvention, Conv.Gamme
UNION
SELECT      Conv.CleConvention, Achat.CleTiers, Achat.CleProduit, SUM(Achat.ca) AS Montant, Conv.Gamme
FROM          (SELECT      dbo.Effet.CleTiers, dbo.Produit.CleProduit, CASE WHEN CleTypeEffet IN (9, 10) THEN (DetailEffet.Quantite * DetailEffet.PrixUnitaireHT * (1 - (DetailEffet.RistournePourcent / 100.00)) 
                                                - dbo.DetailEffet.Cagnote) * (1 - (Effet.RemisePourcent / 100.00)) WHEN CleTypeEffet IN (11, 12) 
                                                THEN - ((DetailEffet.Quantite * DetailEffet.PrixUnitaireHT * (1 - (DetailEffet.RistournePourcent / 100.00)) - dbo.DetailEffet.Cagnote) * (1 - (Effet.RemisePourcent / 100.00))) ELSE 0 END AS ca,
                                                 dbo.Effet.Date
                        FROM           dbo.Effet INNER JOIN
                                                dbo.DetailEffet ON dbo.Effet.CleEffet = dbo.DetailEffet.CleEffet INNER JOIN
                                                dbo.Lot ON dbo.DetailEffet.CleLot = dbo.Lot.CleLot INNER JOIN
                                                dbo.Produit ON dbo.Lot.CleProduit = dbo.Produit.CleProduit
                        WHERE       (dbo.Effet.CleTypeEffet IN (9, 10, 11, 12)) AND (dbo.Effet.Associe = 1)) AS Achat INNER JOIN
                            (SELECT      dbo.Convention.CleConvention, dbo.Convention.Debut, dbo.Convention.Fin, dbo.DetailConvention.CleProduit, dbo.DetailConvention.Gamme, 
                                                      dbo.ConventionFournisseur.CleTiers
                              FROM           dbo.Convention INNER JOIN
                                                      dbo.DetailConvention ON dbo.Convention.CleConvention = dbo.DetailConvention.CleConvention INNER JOIN
                                                      dbo.ConventionFournisseur ON dbo.Convention.CleConvention = dbo.ConventionFournisseur.CleConvention
                              WHERE       (dbo.Convention.Suivi = 1) AND (dbo.Convention.bVente = 0) AND (dbo.Convention.bLabo = 1)) AS Conv ON Conv.CleProduit = Achat.CleProduit AND 
                        Achat.CleTiers = Conv.CleTiers
WHERE      (Achat.Date BETWEEN Conv.Debut AND Conv.Fin)
GROUP BY Achat.CleTiers, Achat.CleProduit, Conv.CleConvention, Conv.Gamme
GO
/****** Object:  View [dbo].[RealisationConvention2]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RealisationConvention2]
AS
SELECT      CleProduit, SUM(MontantHT) AS RealCA, CleConvention, Gamme
FROM          (SELECT      dbo.Effet.Date, dbo.Lot.CleLot, dbo.Produit.CleProduit, dbo.Produit.Code, dbo.Produit.Designation, dbo.Lot.NLot, dbo.Lot.DateExp, CASE WHEN dbo.Effet.CleTypeEffet IN (5, 6) 
                                                THEN DetailEffet.Quantite ELSE 0 END - CASE WHEN dbo.Effet.CleTypeEffet IN (7, 8) THEN DetailEffet.Quantite ELSE 0 END AS QteFr, CASE WHEN dbo.Effet.CleTypeEffet IN (5, 6) 
                                                THEN DetailEffet.Quantite * CASE Detail.PrixAppliquer WHEN 0 THEN Lot.PrixAchat WHEN 1 THEN Lot.PrixVente WHEN 2 THEN Lot.PrixGros ELSE 0 END ELSE 0 END - CASE WHEN dbo.Effet.CleTypeEffet
                                                 IN (7, 8) 
                                                THEN DetailEffet.Quantite * CASE Detail.PrixAppliquer WHEN 0 THEN Lot.PrixAchat WHEN 1 THEN Lot.PrixVente WHEN 2 THEN Lot.PrixGros ELSE 0 END ELSE 0 END AS MontantHT, 
                                                dbo.Tiers.RaisonSociale, dbo.Produit.Quantite, Detail.CleConvention, Detail.RistourneSupp, Detail.Montant, Detail.Gamme
                        FROM           dbo.Effet INNER JOIN
                                                dbo.Produit INNER JOIN
                                                dbo.Lot ON dbo.Produit.CleProduit = dbo.Lot.CleProduit INNER JOIN
                                                dbo.DetailEffet ON dbo.Lot.CleLot = dbo.DetailEffet.CleLot ON dbo.Effet.CleEffet = dbo.DetailEffet.CleEffet INNER JOIN
                                                    (SELECT      dbo.DetailConvention.CleDetailConvention, dbo.DetailConvention.CleConvention, dbo.DetailConvention.CleProduit, dbo.DetailConvention.Gamme, 
                                                                              dbo.DetailConvention.RistourneSupp, dbo.DetailConvention.Montant, dbo.Convention.Debut, dbo.Convention.Fin, dbo.Convention.PrixAppliquer
                                                      FROM           dbo.DetailConvention INNER JOIN
                                                                              dbo.Convention ON dbo.DetailConvention.CleConvention = dbo.Convention.CleConvention
                                                      WHERE       (dbo.Convention.bVente = 1)) AS Detail ON dbo.Produit.CleProduit = Detail.CleProduit AND dbo.Effet.Date >= Detail.Debut AND dbo.Effet.Date <= Detail.Fin LEFT OUTER JOIN
                                                dbo.Tiers ON dbo.Effet.CleTiers = dbo.Tiers.CleTiers
                        WHERE       (dbo.Effet.CleTypeEffet IN (6, 8))) AS RealisationConvention
GROUP BY CleProduit, CleConvention, Gamme

GO
/****** Object:  View [dbo].[JConvention]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JConvention]
AS
SELECT      TOP (100) PERCENT dbo.Convention.CleConvention, dbo.Convention.Reference, dbo.Convention.Date, dbo.Tiers.CodeTiers, dbo.Tiers.RaisonSociale, dbo.Convention.Debut, dbo.Convention.Fin, 
                        CASE dbo.Convention.ClePeriode WHEN 1 THEN 'Annuelle' WHEN 2 THEN 'Bimestrielle' WHEN 3 THEN 'Trimestrielle' WHEN 4 THEN 'Mensuelle' WHEN 5 THEN 'Quadrimestrielle' WHEN 6 THEN 'Personnalisé'
                         END AS Periode, CONVERT(DECIMAL(20, 2), SUM(CASE WHEN Real.Mont IS NULL THEN 0 ELSE Real.Mont END)) AS Montant, CONVERT(DECIMAL(20, 2), 
                        AVG(CASE WHEN palier.Montant IS NOT NULL THEN (CASE WHEN Real.Mont IS NULL THEN 0 ELSE Real.Mont END) / palier.Montant * 100.00 ELSE 0 END)) AS Real, CONVERT(DECIMAL(20, 2), 
                        SUM(CASE WHEN palier.Ristourne IS NOT NULL THEN (CASE WHEN Real.Mont IS NULL THEN 0 ELSE Real.Mont END) * palier.Ristourne / 100.00 ELSE 0 END)) AS Rist, dbo.Convention.Signataire, 
                        dbo.Convention.SignataireFrs, dbo.Convention.DelaiReclamation, dbo.Convention.DelaiRejet, dbo.Convention.Penalite, dbo.Convention.TauxMaxPerime, dbo.[User].Name, dbo.Convention.Cloture, 
                        dbo.Convention.CleTiers, dbo.Tiers.CleTypeTiers, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, dbo.Convention.Suivi, dbo.Convention.bLabo, 
                        dbo.Convention.ClePeriode, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, CASE WHEN dbo.Convention.bVente = 0 THEN 0 ELSE 1 END AS bVent, CASE WHEN dbo.Convention.bHT = 0 THEN 0 ELSE 1 END AS bHTx, dbo.Convention.PrixAppliquer, 
                        CASE WHEN Doc.CleConvention IS NULL THEN 0 ELSE 1 END AS bDoc, dbo.Convention.RealisationPalier, dbo.Convention.SupplementProduit, dbo.Convention.SupplementGamme, 
                        dbo.Convention.SupplementPhasing, dbo.Convention.Ecart, 
                        dbo.Convention.RealisationPalier + dbo.Convention.SupplementProduit + dbo.Convention.SupplementGamme + dbo.Convention.SupplementPhasing + dbo.Convention.Ecart AS Total, 
                        dbo.Convention.Payement, 
                        dbo.Convention.RealisationPalier + dbo.Convention.SupplementProduit + dbo.Convention.SupplementGamme + dbo.Convention.SupplementPhasing + dbo.Convention.Ecart - dbo.Convention.Payement
                         AS Reste
FROM          (SELECT      CleConvention, SUM(Montant) AS Mont, Gamme
                        FROM           dbo.RealisationConvention
                        GROUP BY CleConvention, Gamme
                        UNION
                        SELECT      CleConvention, SUM(RealCA) AS Mont, Gamme
                        FROM          dbo.RealisationConvention2
                        GROUP BY CleConvention, Gamme
                        UNION
                        SELECT      Convention_1.CleConvention, SUM(CASE WHEN CleTypeEffet = 5 THEN dbo.EffetAll.MonantTTC WHEN CleTypeEffet IN (7, 2) THEN - dbo.EffetAll.MonantTTC END) AS MontantTTC, 
                                                '' AS Gam
                        FROM          dbo.EffetAll INNER JOIN
                                                dbo.Convention AS Convention_1 ON dbo.EffetAll.CleTiers = Convention_1.CleTiers
                        WHERE      (dbo.EffetAll.Date BETWEEN Convention_1.Debut AND Convention_1.Fin) AND (dbo.EffetAll.bUseTauxRemise = 1) AND (dbo.EffetAll.CleTypeEffet IN (5, 7, 2)) AND (Convention_1.Suivi = 0)
                        GROUP BY dbo.EffetAll.CleTiers, Convention_1.CleConvention) AS Real RIGHT OUTER JOIN
                            (SELECT      CleConventionPalier, CleConvention, Gamme, Montant, Ristourne, bObjectif, RistourneSupp
                              FROM           dbo.ConventionPalier
                              WHERE       (bObjectif = 1)) AS palier ON Real.Gamme = palier.Gamme AND Real.CleConvention = palier.CleConvention RIGHT OUTER JOIN
                        dbo.Convention ON palier.CleConvention = dbo.Convention.CleConvention LEFT OUTER JOIN
                            (SELECT      CleConvention
                              FROM           dbo.DocConvention
                              GROUP BY CleConvention) AS Doc ON dbo.Convention.CleConvention = Doc.CleConvention LEFT OUTER JOIN
                        dbo.Tiers ON dbo.Convention.CleTiers = dbo.Tiers.CleTiers LEFT OUTER JOIN
                        dbo.[User] ON dbo.Convention.CleUser = dbo.[User].CleUser
WHERE      (dbo.Convention.CleTypeConvention = 1)
GROUP BY dbo.Convention.CleConvention, dbo.Convention.Reference, dbo.Convention.Date, dbo.Tiers.CodeTiers, dbo.Tiers.RaisonSociale, dbo.Convention.Debut, dbo.Convention.Fin, 
                        dbo.Convention.Signataire, dbo.Convention.SignataireFrs, dbo.Convention.DelaiReclamation, dbo.Convention.DelaiRejet, dbo.Convention.Penalite, dbo.Convention.TauxMaxPerime, 
                        dbo.[User].Name, dbo.Convention.CleTiers, dbo.Tiers.CleTypeTiers, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, dbo.Convention.Suivi, 
                        dbo.Convention.ClePeriode, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, dbo.Convention.Payement, 
                        CASE dbo.Convention.ClePeriode WHEN 1 THEN 'Annuelle' WHEN 2 THEN 'Bimestrielle' WHEN 3 THEN 'Trimestrielle' WHEN 4 THEN 'Mensuelle' END, dbo.Convention.Cloture, 
                        dbo.Convention.bLabo, dbo.Convention.PrixAppliquer, CASE WHEN dbo.Convention.bVente = 0 THEN 0 ELSE 1 END, CASE WHEN dbo.Convention.bHT = 0 THEN 0 ELSE 1 END, CASE WHEN Doc.CleConvention IS NULL THEN 0 ELSE 1 END, 
                        dbo.Convention.RealisationPalier, dbo.Convention.SupplementProduit, dbo.Convention.SupplementGamme, dbo.Convention.SupplementPhasing, dbo.Convention.Ecart
ORDER BY dbo.Convention.CleConvention
GO
/****** Object:  View [dbo].[JConvention2]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JConvention2]
AS
SELECT      TOP (100) PERCENT dbo.Convention.CleConvention, dbo.Convention.Reference, dbo.Convention.Date, dbo.Tiers.CodeTiers, dbo.Tiers.RaisonSociale, dbo.Convention.Debut, dbo.Convention.Fin, 
                        CASE dbo.Convention.ClePeriode WHEN 1 THEN 'Annuelle' WHEN 2 THEN 'Bimestrielle' WHEN 3 THEN 'Trimestrielle' WHEN 4 THEN 'Mensuelle' WHEN 5 THEN 'Quadrimestrielle' WHEN 6 THEN 'Personnalisé'
                         END AS Periode, CONVERT(DECIMAL(20, 2), SUM(CASE WHEN Real.Mont IS NULL THEN 0 ELSE Real.Mont END)) AS Montant, CONVERT(DECIMAL(20, 2), 
                        AVG(CASE WHEN palier.Montant IS NOT NULL THEN (CASE WHEN Real.Mont IS NULL THEN 0 ELSE Real.Mont END) / palier.Montant * 100.00 ELSE 0 END)) AS Real, CONVERT(DECIMAL(20, 2), 
                        SUM(CASE WHEN palier.Ristourne IS NOT NULL THEN (CASE WHEN Real.Mont IS NULL THEN 0 ELSE Real.Mont END) * palier.Ristourne / 100.00 ELSE 0 END)) AS Rist, dbo.Convention.Signataire, 
                        dbo.Convention.SignataireFrs, dbo.Convention.DelaiReclamation, dbo.Convention.DelaiRejet, dbo.Convention.Penalite, dbo.Convention.TauxMaxPerime, dbo.[User].Name, dbo.Convention.Cloture, 
                        dbo.Convention.CleTiers, dbo.Tiers.CleTypeTiers, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, dbo.Convention.Suivi, dbo.Convention.bLabo, 
                        dbo.Convention.ClePeriode, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, dbo.Convention.Payement, CONVERT(DECIMAL(20, 2), SUM(CASE WHEN palier.Ristourne IS NOT NULL 
                        THEN (CASE WHEN Real.Mont IS NULL THEN 0 ELSE Real.Mont END) * palier.Ristourne / 100.00 ELSE 0 END)) + dbo.Convention.Ecart - dbo.Convention.Payement AS Reste, dbo.Convention.Ecart, 
                        CASE WHEN Doc.CleConvention IS NULL THEN 0 ELSE 1 END AS bDoc
FROM          (SELECT      CleConvention, SUM(Montant) AS Mont, Gamme
                        FROM           dbo.RealisationConvention
                        GROUP BY CleConvention, Gamme
                        UNION
                        SELECT      Convention_1.CleConvention, SUM(CASE WHEN CleTypeEffet = 6 THEN dbo.EffetAll.MonantTTC WHEN CleTypeEffet IN (8, 1) THEN - dbo.EffetAll.MonantTTC END) AS MontantTTC, 
                                                '' AS Gam
                        FROM          dbo.EffetAll INNER JOIN
                                                dbo.Convention AS Convention_1 ON dbo.EffetAll.CleTiers = Convention_1.CleTiers
                        WHERE      (dbo.EffetAll.Date BETWEEN Convention_1.Debut AND Convention_1.Fin) AND (dbo.EffetAll.bUseTauxRemise = 1) AND (dbo.EffetAll.CleTypeEffet IN (6, 8, 1)) AND (Convention_1.Suivi = 0)
                        GROUP BY dbo.EffetAll.CleTiers, Convention_1.CleConvention) AS Real RIGHT OUTER JOIN
                            (SELECT      CleConventionPalier, CleConvention, Gamme, Montant, Ristourne, bObjectif, RistourneSupp
                              FROM           dbo.ConventionPalier
                              WHERE       (bObjectif = 1)) AS palier ON Real.Gamme = palier.Gamme AND Real.CleConvention = palier.CleConvention RIGHT OUTER JOIN
                        dbo.Convention ON palier.CleConvention = dbo.Convention.CleConvention LEFT OUTER JOIN
                            (SELECT      CleConvention
                              FROM           dbo.DocConvention
                              GROUP BY CleConvention) AS Doc ON dbo.Convention.CleConvention = Doc.CleConvention LEFT OUTER JOIN
                        dbo.Tiers ON dbo.Convention.CleTiers = dbo.Tiers.CleTiers LEFT OUTER JOIN
                        dbo.[User] ON dbo.Convention.CleUser = dbo.[User].CleUser
WHERE      (dbo.Convention.CleTypeConvention = 2)
GROUP BY dbo.Convention.CleConvention, dbo.Convention.Reference, dbo.Convention.Date, dbo.Tiers.CodeTiers, dbo.Tiers.RaisonSociale, dbo.Convention.Debut, dbo.Convention.Fin, 
                        dbo.Convention.Signataire, dbo.Convention.SignataireFrs, dbo.Convention.DelaiReclamation, dbo.Convention.DelaiRejet, dbo.Convention.Penalite, dbo.Convention.TauxMaxPerime, 
                        dbo.[User].Name, dbo.Convention.CleTiers, dbo.Tiers.CleTypeTiers, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, dbo.Convention.Suivi, 
                        dbo.Convention.ClePeriode, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, dbo.Convention.Payement, 
                        CASE dbo.Convention.ClePeriode WHEN 1 THEN 'Annuelle' WHEN 2 THEN 'Bimestrielle' WHEN 3 THEN 'Trimestrielle' WHEN 4 THEN 'Mensuelle' END, dbo.Convention.Cloture, 
                        dbo.Convention.bLabo, CASE WHEN Doc.CleConvention IS NULL THEN 0 ELSE 1 END, dbo.Convention.Ecart
ORDER BY dbo.Convention.CleConvention
GO
/****** Object:  View [dbo].[JCAGNOTEX]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JCAGNOTEX]
AS
SELECT      CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, MontantHT, MonantTTC, Mode, Payement, Rest + 0 AS Reste, Timbre, TotalTVA, TotalSHP, TotalPPA, Commercial, Vendeur, 
                        Remis, RemisPourcent + 0 AS RemisePourcent, RemisPourcent2 + 0 AS RemisePourcent2, Remis2, bRemise, bRemise2, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, 
                        TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, 
                        CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, MonUG AS MontantCagnote, PayementCagno AS PayementCagnote, CleUserAss, 
                        bCagnote, CONVERT(DECIMAL(10, 2), MonUG * (RemiseCagnote / 100.00)) + CONVERT(DECIMAL(10, 2), (Remis + Remis3) * (RemiseCagnote / 100.00)) + CONVERT(DECIMAL(10, 2), 
                        Remis2 * (RemiseCagnote / 100.00)) AS TAP, CONVERT(DECIMAL(10, 2), MonUG * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), (Remis + Remis3) 
                        * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), Remis2 * (1 - RemiseCagnote / 100.00) + 0.000001) AS NetCagnotte, CONVERT(DECIMAL(10, 2), 
                        MonUG * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), (Remis + Remis3) * (1 - RemiseCagnote / 100.00) + 0.000001) + CONVERT(DECIMAL(10, 2), 
                        Remis2 * (1 - RemiseCagnote / 100.00) + 0.000001) - PayementCagno AS ResteCagnote, RemiseCagnote, PayementUG, PayementRemise, PayementRemise2, CleStatutTiers, CleSolvabilite, 
                        CleUserActuel, Remis + Remis3 AS Remis13, Remis3
FROM          (SELECT      TOP (100) PERCENT dbo.JournalEffet.CleEffet, dbo.JournalEffet.CleTypeEffet, Eff.Reference, Eff.Date, dbo.JournalEffet.Date2, dbo.JournalEffet.CodeTiers, dbo.JournalEffet.RaisonSociale, 
                                                Eff.MontantHT, Eff.MonantTTC, dbo.JournalEffet.Mode, Eff.Payement, Eff.MonantTTC - Eff.Payement AS Rest, dbo.JournalEffet.Timbre, dbo.JournalEffet.TotalTVA, 
                                                dbo.JournalEffet.TotalSHP, dbo.JournalEffet.TotalPPA, dbo.JournalEffet.Commercial, dbo.JournalEffet.Vendeur, CASE WHEN JournalEffet.bRemise = 0 THEN CONVERT(DECIMAL(10, 2), 
                                                JournalEffet.Remise) ELSE 0 END AS Remis, CASE WHEN JournalEffet.bRemise = 0 THEN JournalEffet.RemisePourcent ELSE 0 END AS RemisPourcent, 
                                                CASE WHEN JournalEffet.bRemise2 = 0 THEN JournalEffet.RemisePourcent2 ELSE 0 END AS RemisPourcent2, CASE WHEN JournalEffet.bRemise2 = 0 THEN CONVERT(DECIMAL(10, 2), 
                                                JournalEffet.Remise2) ELSE 0 END AS Remis2, dbo.JournalEffet.bRemise, dbo.JournalEffet.bRemise2, dbo.JournalEffet.NetHT, dbo.JournalEffet.CategorieEffet, dbo.JournalEffet.Name, 
                                                dbo.JournalEffet.Depot, dbo.JournalEffet.EtatEffet, dbo.JournalEffet.CategorieTiers, dbo.JournalEffet.Vehicule, dbo.JournalEffet.TypeTiers, dbo.JournalEffet.FamilleTiers, 
                                                dbo.JournalEffet.Region, dbo.JournalEffet.Wilaya, dbo.JournalEffet.Associe, dbo.JournalEffet.Cloture, dbo.JournalEffet.CleEntreprise, dbo.JournalEffet.CleTiers, 
                                                dbo.JournalEffet.CleCategorieEffet, dbo.JournalEffet.CleUser, dbo.JournalEffet.CleCommercial, dbo.JournalEffet.CleMode, dbo.JournalEffet.CleDepot, dbo.JournalEffet.CleVehicule, 
                                                dbo.JournalEffet.CleVendeur, dbo.JournalEffet.CleEtatEffet, dbo.JournalEffet.CleTypeTiers, dbo.JournalEffet.CleFamilleTiers, dbo.JournalEffet.CleWilaya, dbo.JournalEffet.CleRegion, 
                                                dbo.JournalEffet.CleCategorieTiers, dbo.JournalEffet.CleTransaction, dbo.JournalEffet.Couleur, dbo.JournalEffet.CouleurEtat, 
                                                CASE WHEN JournalEffet.bCagnote = 0 THEN CONVERT(DECIMAL(10, 2), dbo.JournalEffet.MontantCagnote) ELSE 0 END AS MonUG, 
                                                dbo.JournalEffet.PayementCagnote + dbo.JournalEffet.PayementRemise + dbo.JournalEffet.PayementRemise2 AS PayementCagno, dbo.JournalEffet.CleUserAss, 
                                                dbo.JournalEffet.bCagnote, dbo.JournalEffet.RemiseCagnote, dbo.JournalEffet.PayementCagnote AS PayementUG, dbo.JournalEffet.PayementRemise, 
                                                dbo.JournalEffet.PayementRemise2, dbo.JournalEffet.CleStatutTiers, dbo.JournalEffet.CleSolvabilite, dbo.JournalEffet.CleUserActuel, CONVERT(DECIMAL(10, 2), 
                                                dbo.JournalEffet.Remise3) AS Remis3
                        FROM           dbo.JournalEffet INNER JOIN
                                                    (SELECT      Reference, Date, MontantHT, MonantTTC, Payement
                                                      FROM           dbo.Effet
                                                      WHERE       (CleTypeEffet IN (6, 8))) AS Eff ON dbo.JournalEffet.RefBC = Eff.Reference
                        WHERE       (dbo.JournalEffet.CleTypeEffet IN (10, 12)) AND (Eff.Reference IS NOT NULL)
                        ORDER BY dbo.JournalEffet.CleEffet DESC) AS JournalCagnote
GO
/****** Object:  View [dbo].[Produit_mvt]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Produit_mvt]
AS
SELECT        dbo.Lot.CleProduit
FROM            dbo.Lot INNER JOIN
                         dbo.DetailEffet ON dbo.Lot.CleLot = dbo.DetailEffet.CleLot INNER JOIN
                         dbo.Effet ON dbo.DetailEffet.CleEffet = dbo.Effet.CleEffet
WHERE        (dbo.Effet.CleTypeEffet IN (9, 10, 11, 12, 13, 14, 15, 16))
GROUP BY dbo.Lot.CleProduit




GO
/****** Object:  View [dbo].[JPRODUIT]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JPRODUIT]
AS
SELECT      dbo.Produit.CleProduit, dbo.Produit.Code, dbo.Produit.Reference, dbo.Produit.Designation, dbo.Produit.Designation2, dbo.Produit.Remarque, dbo.Produit.FullDesignation, dbo.Produit.Quantite, 
                        dbo.Produit.QF, dbo.Produit.QuantiteAlerte, dbo.Produit.QuantiteMax, dbo.Produit.QuantiteAlerte2, dbo.Produit.QuantiteMax2, dbo.Produit.Unite, dbo.Produit.PMP, dbo.Produit.DernierPrixAchat, 
                        dbo.Produit.bBorneAchatActive, dbo.Produit.PrixAchatMin, dbo.Produit.PrixAchatMax, dbo.Produit.bBorneVenteActive, dbo.Produit.PrixVenteMin, dbo.Produit.PrixVenteMax, dbo.Produit.QteArrivage, 
                        dbo.Produit.QteReserve, dbo.Produit.PoidU, dbo.Produit.VolumeU, dbo.FamilleArticle.FamilleArticle, dbo.Taxe.Valeur, dbo.Emplacement.Emplacement, dbo.StatutLot.StatutLot, dbo.Marque.Marque, 
                        dbo.CategorieProduit.CategorieProduit, dbo.Colissage.Colissage, dbo.Colissage.Facteur, dbo.Produit.HorsStock, dbo.Produit.PrixModifiable, dbo.Produit.bPerimable, dbo.Produit.bBloque, 
                        dbo.Produit.bUseLot, dbo.Produit.bCompose, dbo.Produit.bMatierePremiere, dbo.Produit.bVenteEnEtat, dbo.Produit.bSerial, dbo.Produit.bCommission, dbo.Produit.bQuota, 
                        dbo.Produit.bCodeInterprete, dbo.Produit.bSortieControle, dbo.Produit.Marge, dbo.Produit.SHP, dbo.Produit.MaxUG, dbo.Produit.TR, dbo.Produit.RistPromo, dbo.Produit.DebutPromo, 
                        dbo.Produit.FinPromo, dbo.Produit.Coef1, dbo.Produit.Coef2, dbo.Produit.Photo, dbo.Produit.CreateDate, dbo.Produit.LastModifiedDate, dbo.Produit.KeyWords, dbo.Produit.bUseInfoUnite, 
                        dbo.Produit.Condit, dbo.Produit.CleArchiveColisage, dbo.Produit.CleFamilleArticle, dbo.Produit.CleTVA, dbo.Produit.CleEmplacement, dbo.Produit.CleStatutLot, dbo.Produit.CleMarque, 
                        dbo.Produit.CleCategorieProduit, dbo.Produit.CleDefaultColisage, dbo.CategorieProduit.Couleur, dbo.Produit.CleDCI, dbo.Produit.Invisible, CASE WHEN Produit_mvt.CleProduit IS NOT NULL 
                        THEN 1 ELSE 0 END AS bMvt, dbo.Produit.bPsycho, dbo.Labo.Labo, dbo.Produit.CleLabo, CASE WHEN Doc.CleProduit IS NULL THEN 0 ELSE 1 END AS bDoc
FROM          dbo.Produit LEFT OUTER JOIN
                        dbo.Labo ON dbo.Produit.CleLabo = dbo.Labo.CleLabo LEFT OUTER JOIN
                        dbo.Produit_mvt ON dbo.Produit.CleProduit = dbo.Produit_mvt.CleProduit LEFT OUTER JOIN
                        dbo.FamilleArticle ON dbo.Produit.CleFamilleArticle = dbo.FamilleArticle.CleFamilleArticle LEFT OUTER JOIN
                        dbo.Marque ON dbo.Produit.CleMarque = dbo.Marque.CleMarque LEFT OUTER JOIN
                        dbo.Colissage ON dbo.Produit.CleDefaultColisage = dbo.Colissage.CleColissage LEFT OUTER JOIN
                        dbo.CategorieProduit ON dbo.Produit.CleCategorieProduit = dbo.CategorieProduit.CleCategorieProduit LEFT OUTER JOIN
                        dbo.Taxe ON dbo.Produit.CleTVA = dbo.Taxe.CleTaxe LEFT OUTER JOIN
                        dbo.StatutLot ON dbo.Produit.CleStatutLot = dbo.StatutLot.CleStatutLot LEFT OUTER JOIN
                        dbo.Emplacement ON dbo.Produit.CleEmplacement = dbo.Emplacement.CleEmplacement LEFT OUTER JOIN
                            (SELECT      CleProduit
                              FROM           dbo.DocProduit
                              GROUP BY CleProduit) AS Doc ON dbo.Produit.CleProduit = Doc.CleProduit




GO
/****** Object:  View [dbo].[DetailOpComptoirLot]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DetailOpComptoirLot]
AS
SELECT      dbo.Lot.CleLot, dbo.Lot.CleProduit, dbo.Lot.CodeLot, dbo.Lot.NLot, dbo.Lot.DateExp, dbo.Lot.PrixAchat, dbo.Lot.PrixVente, dbo.Lot.PrixVenteTTC, dbo.Lot.PrixGros, dbo.Lot.PPA, dbo.Lot.SHP, 
                        dbo.Lot.Marge AS Expr3, dbo.Lot.MargePh, dbo.Lot.MargeGros, dbo.Lot.CleStatutLot, dbo.Lot.CleMarque, dbo.Lot.Condit, dbo.Lot.Date2, dbo.Lot.CleEmplacement, 
                        dbo.DetailOpComptoir.CleDetailOpComptoir, dbo.DetailOpComptoir.CleOpComptoir, dbo.DetailOpComptoir.Quantite, dbo.DetailOpComptoir.PrixUnitaireHT, dbo.DetailOpComptoir.TVAPourcent, 
                        dbo.DetailOpComptoir.Ristourne, dbo.DetailOpComptoir.PrixUnitaireTTC, dbo.DetailOpComptoir.PMP, dbo.DetailOpComptoir.CleDepot, dbo.DetailOpComptoir.bNotFixed, dbo.Produit.Code, 
                        dbo.Produit.Designation, dbo.Produit.TR, dbo.DetailOpComptoir.Duree, dbo.Produit.CleFamilleArticle, dbo.Produit.CleCategorieProduit, dbo.Produit.CleDCI
FROM          dbo.Lot INNER JOIN
                        dbo.DetailOpComptoir ON dbo.Lot.CleLot = dbo.DetailOpComptoir.CleLot INNER JOIN
                        dbo.Produit ON dbo.Lot.CleProduit = dbo.Produit.CleProduit




GO
/****** Object:  View [dbo].[JVENTECPTLOT2]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JVENTECPTLOT2]
AS
SELECT      TOP (100) PERCENT dbo.OpComptoir.CleOpComptoir, dbo.OpComptoir.CleTrace, dbo.OpComptoir.CleTypeOperation, dbo.OpComptoir.CleCaisseComptoir, dbo.OpComptoir.Reference, 
                        dbo.OpComptoir.Libelle, dbo.OpComptoir.CleTiers, dbo.OpComptoir.CleUser, dbo.OpComptoir.Heure, dbo.OpComptoir.CleEtatOpComptoir, dbo.OpComptoir.CleDepot, 
                        dbo.TypeOpComptoir.TypeOperation, dbo.CaisseComptoir.CaisseComptoir, dbo.CaisseComptoir.Montant, dbo.EtatOpComptoir.EtatOpComptoir, dbo.[User].Name, dbo.Tiers.CodeTiers, 
                        dbo.Tiers.RaisonSociale, dbo.Depot.Depot, dbo.DetailOpComptoirLot.CleLot, dbo.DetailOpComptoirLot.CleProduit, dbo.DetailOpComptoirLot.CodeLot, dbo.DetailOpComptoirLot.NLot, 
                        dbo.DetailOpComptoirLot.DateExp, dbo.DetailOpComptoirLot.PPA, dbo.DetailOpComptoirLot.SHP, dbo.DetailOpComptoirLot.MargePh, dbo.DetailOpComptoirLot.CleStatutLot, 
                        dbo.DetailOpComptoirLot.CleMarque, CASE dbo.OpComptoir.CleTypeOperation WHEN 1 THEN dbo.DetailOpComptoirLot.Quantite ELSE - dbo.DetailOpComptoirLot.Quantite END AS qtt, 
                        dbo.DetailOpComptoirLot.PrixUnitaireHT, 
                        CASE dbo.OpComptoir.CleTypeOperation WHEN 1 THEN dbo.DetailOpComptoirLot.Quantite * dbo.DetailOpComptoirLot.PrixUnitaireTTC * (1 - dbo.DetailOpComptoirLot.Ristourne / 100) 
                        ELSE - (dbo.DetailOpComptoirLot.Quantite * dbo.DetailOpComptoirLot.PrixUnitaireTTC * (1 - dbo.DetailOpComptoirLot.Ristourne / 100)) END AS montt, dbo.DetailOpComptoirLot.TVAPourcent, 
                        dbo.DetailOpComptoirLot.Ristourne, dbo.DetailOpComptoirLot.PrixUnitaireTTC, dbo.DetailOpComptoirLot.Code, dbo.DetailOpComptoirLot.Designation, dbo.StatutLot.StatutLot, dbo.Marque.Marque, 
                        dbo.OpComptoir.CleGroupeComptoir, dbo.GroupeComptoir.GroupeComptoir, dbo.Tiers.bPoint, dbo.Tiers.Point, dbo.DetailOpComptoirLot.CleEmplacement, dbo.DetailOpComptoirLot.CleFamilleArticle, 
                        dbo.DetailOpComptoirLot.CleCategorieProduit, dbo.DetailOpComptoirLot.CleDCI, dbo.EtatOpComptoir.Couleur, CAST(FORMAT(dbo.OpComptoir.Heure, 'dd-MM-yyyy') AS datetime) AS Dat, 
                        dbo.OpComptoir.RefBLF, dbo.OpComptoir.RefRecu, 
                        CASE dbo.OpComptoir.CleTypeOperation WHEN 1 THEN dbo.DetailOpComptoirLot.PrixAchat * dbo.DetailOpComptoirLot.Quantite ELSE - (dbo.DetailOpComptoirLot.PrixAchat * dbo.DetailOpComptoirLot.Quantite)
                         END AS MontAchat
FROM          dbo.OpComptoir LEFT OUTER JOIN
                        dbo.GroupeComptoir ON dbo.OpComptoir.CleGroupeComptoir = dbo.GroupeComptoir.CleGroupeComptoir LEFT OUTER JOIN
                        dbo.DetailOpComptoirLot ON dbo.OpComptoir.CleOpComptoir = dbo.DetailOpComptoirLot.CleOpComptoir LEFT OUTER JOIN
                        dbo.Marque ON dbo.DetailOpComptoirLot.CleMarque = dbo.Marque.CleMarque LEFT OUTER JOIN
                        dbo.StatutLot ON dbo.DetailOpComptoirLot.CleStatutLot = dbo.StatutLot.CleStatutLot LEFT OUTER JOIN
                        dbo.TypeOpComptoir ON dbo.OpComptoir.CleTypeOperation = dbo.TypeOpComptoir.CleTypeOperation LEFT OUTER JOIN
                        dbo.Depot ON dbo.OpComptoir.CleDepot = dbo.Depot.CleDepot LEFT OUTER JOIN
                        dbo.EtatOpComptoir ON dbo.OpComptoir.CleEtatOpComptoir = dbo.EtatOpComptoir.CleEtatOpComptoir LEFT OUTER JOIN
                        dbo.CaisseComptoir ON dbo.OpComptoir.CleCaisseComptoir = dbo.CaisseComptoir.CleCaisseComptoir LEFT OUTER JOIN
                        dbo.Tiers ON dbo.OpComptoir.CleTiers = dbo.Tiers.CleTiers LEFT OUTER JOIN
                        dbo.[User] ON dbo.OpComptoir.CleUser = dbo.[User].CleUser
WHERE      (dbo.OpComptoir.CleTypeOperation IN (1, 3))
ORDER BY dbo.OpComptoir.CleOpComptoir DESC

GO
/****** Object:  View [dbo].[JVENTECPTLOT]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JVENTECPTLOT]
AS
SELECT      CleOpComptoir, CleTrace, CleTypeOperation, CleCaisseComptoir, Reference, Libelle, CleTiers, CleUser, Heure, CleEtatOpComptoir, CleDepot, TypeOperation, CaisseComptoir, Montant, 
                        EtatOpComptoir, Name, CodeTiers, RaisonSociale, Depot, CleLot, CleProduit, CodeLot, NLot, DateExp, PPA, SHP, MargePh, CleStatutLot, CleMarque, qtt AS Quantite, PrixUnitaireHT, montt AS mont, 
                        TVAPourcent, Ristourne, PrixUnitaireTTC, Code, Designation, StatutLot, Marque, CleGroupeComptoir, GroupeComptoir, bPoint, Point, CleEmplacement, CleFamilleArticle, CleCategorieProduit, CleDCI,
                         Couleur, Dat, RefBLF, RefRecu, MontAchat
FROM          dbo.JVENTECPTLOT2

GO
/****** Object:  View [dbo].[JCTRCL]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JCTRCL]
AS
SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT + 0 AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, 
                        TotalPPA, Commercial, Vendeur, Remise, RemisePourcent, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, 
                        CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, CleUserAss, Invisible, MontantBrute, RemisePourcent2, Remise2, bDoc, bPsycho, bControle, CleStatutTiers, CleSolvabilite, 
                        CleUserActuel
FROM          dbo.JournalEffet
WHERE      (CleTypeEffet = 17)
ORDER BY CleEffet DESC
GO
/****** Object:  View [dbo].[JSSPECIAL]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JSSPECIAL]
AS
SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT + 0 AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, 
                        TotalPPA, Commercial, Vendeur, Remise, RemisePourcent, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, 
                        CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, CleUserAss, Invisible, MontantBrute, RemisePourcent2, Remise2, bDoc, Préparateur, Contrôleur, bPsycho, bControle, CleStatutTiers, 
                        CleSolvabilite, colisa, CleUserActuel
FROM          dbo.JournalEffet
WHERE      (CleTypeEffet IN (13, 14, 15, 16))
ORDER BY CleEffet DESC
GO
/****** Object:  View [dbo].[JSTOCK]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JSTOCK]
AS
SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT + 0 AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, 
                        TotalPPA, Commercial, Vendeur, CASE WHEN bRemise = 0 AND CleTypeEffet IN (10, 12) THEN 0 ELSE Remise END AS Remis, CASE WHEN bRemise = 0 AND CleTypeEffet IN (10, 12) 
                        THEN 0 ELSE RemisePourcent END AS RemisPourcent, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, 
                        CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, CleUserAss, Invisible, MontantBrute, CASE WHEN bRemise2 = 0 AND CleTypeEffet IN (10, 12) THEN 0 ELSE Remise2 END AS Remis2, 
                        CASE WHEN bRemise2 = 0 AND CleTypeEffet IN (10, 12) THEN 0 ELSE RemisePourcent2 END AS RemisPourcent2, bDoc, Préparateur, Contrôleur, bPsycho, bControle, CleStatutTiers, CleSolvabilite,
                         colisa, CleUserActuel
FROM          dbo.JournalEffet
WHERE      (CleTypeEffet IN (9, 10, 11, 12, 13, 14, 15, 16))
ORDER BY CleEffet DESC
GO
/****** Object:  View [dbo].[JACHAT]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JACHAT]
AS
SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT + 0 AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, 
                        TotalPPA, Commercial, Vendeur, Remise, RemisePourcent, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, 
                        CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, CleUserAss, Invisible, MontantBrute, RemisePourcent2, Remise2, bDoc, bCompta, bPsycho, bControle, CleStatutTiers, CleSolvabilite, 
                        colisa, CleUserActuel
FROM          dbo.JournalEffet
WHERE      (CleTypeEffet IN (5, 7))
ORDER BY CleEffet DESC
GO
/****** Object:  View [dbo].[JPROFORMAT]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JPROFORMAT]
AS
SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT + 0 AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, 
                        TotalPPA, Commercial, Vendeur, Remise, RemisePourcent, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, 
                        CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, CleUserAss, Invisible, MontantBrute, RemisePourcent2, Remise2, bDoc, bPsycho, bControle, CleStatutTiers, CleSolvabilite, RemiseApp, 
                        RemiseAvf, CleUserActuel
FROM          dbo.JournalEffet
WHERE      (CleTypeEffet = 2)
ORDER BY CleEffet DESC
GO
/****** Object:  View [dbo].[JCMDFR]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JCMDFR]
AS
SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT + 0 AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, 
                        TotalPPA, Commercial, Vendeur, Remise, RemisePourcent, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, 
                        CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, CleUserAss, Invisible, MontantBrute, RemisePourcent2, Remise2, bDoc, bPsycho, bControle, CleStatutTiers, CleSolvabilite, 
                        CleUserActuel
FROM          dbo.JournalEffet
WHERE      (CleTypeEffet = 3)
ORDER BY CleEffet DESC
GO
/****** Object:  View [dbo].[JCTRFR]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JCTRFR]
AS
SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT + 0 AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, 
                        TotalPPA, Commercial, Vendeur, Remise, RemisePourcent, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, 
                        CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, CleUserAss, Invisible, MontantBrute, RemisePourcent2, Remise2, bDoc, bPsycho, bControle, CleStatutTiers, CleSolvabilite, 
                        CleUserActuel
FROM          dbo.JournalEffet
WHERE      (CleTypeEffet = 18)
ORDER BY CleEffet DESC
GO
/****** Object:  View [dbo].[JVENTE]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JVENTE]
AS
SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT + 0 AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, 
                        TotalPPA, Commercial, Vendeur, CASE WHEN bRemise = 0 AND CleTypeEffet IN (6, 8) THEN 0 ELSE Remise END AS Remis, CASE WHEN bRemise = 0 AND CleTypeEffet IN (6, 8) 
                        THEN 0 ELSE RemisePourcent END AS RemisPourcent, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, 
                        CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, CleUserAss, Invisible, MontantBrute, CASE WHEN bRemise2 = 0 AND CleTypeEffet IN (6, 8) THEN 0 ELSE Remise2 END AS Remis2, 
                        CASE WHEN bRemise2 = 0 AND CleTypeEffet IN (6, 8) THEN 0 ELSE RemisePourcent2 END AS RemisPourcent2, bDoc, bCompta, bPsycho, bControle, CleStatutTiers, CleSolvabilite, colisa, 
                        RemiseApp, RemiseAvf, PayementRemiseAvf, RemiseAvf + CagnoteConsome - PayementRemiseAvf AS ResteAvf, CagnoteConsome, CleUserActuel
FROM          dbo.JournalEffet
WHERE      (CleTypeEffet IN (6, 8))
ORDER BY CleEffet DESC
GO
/****** Object:  View [dbo].[bsQteProduit]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[bsQteProduit]
AS
SELECT     CleProduit, SUM(Quantite) AS QuantiteProduit
FROM         dbo.Lot
GROUP BY CleProduit




GO
/****** Object:  View [dbo].[rsProduit]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[rsProduit]
AS
SELECT     dbo.Produit.CleProduit, dbo.Produit.Code, dbo.Produit.Reference, dbo.Produit.Designation, dbo.Produit.Designation2, dbo.Produit.Remarque, 
                      dbo.Produit.FullDesignation, dbo.Produit.Quantite, dbo.Produit.QF, dbo.Produit.QuantiteAlerte, dbo.Produit.QuantiteMax, dbo.Produit.QuantiteAlerte2, 
                      dbo.Produit.QuantiteMax2, dbo.Produit.Unite, dbo.Produit.PMP, dbo.Produit.DernierPrixAchat, dbo.Produit.bBorneAchatActive, dbo.Produit.PrixAchatMin, 
                      dbo.Produit.PrixAchatMax, dbo.Produit.bBorneVenteActive, dbo.Produit.PrixVenteMin, dbo.Produit.PrixVenteMax, dbo.Produit.PrixVenteMin2, 
                      dbo.Produit.PrixVenteMax2, dbo.Produit.QteArrivage, dbo.Produit.QteReserve, dbo.Produit.PoidU, dbo.Produit.VolumeU, dbo.Produit.CleFamilleArticle, 
                      dbo.Produit.CleTVA, dbo.Produit.CleDico, dbo.Produit.CleEmplacement, dbo.Produit.CleStatutLot, dbo.Produit.CleUser, dbo.Produit.CleMarque, 
                      dbo.Produit.CleCategorieProduit, dbo.Produit.CleDefaultColisage, dbo.Produit.HorsStock, dbo.Produit.PrixModifiable, dbo.Produit.bPerimable, dbo.Produit.bBloque, 
                      dbo.Produit.bUseLot, dbo.Produit.bCompose, dbo.Produit.bPsycho, dbo.Produit.bMatierePremiere, dbo.Produit.bVenteEnEtat, dbo.Produit.bSerial, 
                      dbo.Produit.bCommission, dbo.Produit.bQuota, dbo.Produit.bCodeInterprete, dbo.Produit.bSortieControle, dbo.Produit.Marge, dbo.Produit.SHP, dbo.Produit.MaxUG, 
                      dbo.Produit.TR, dbo.Produit.RistPromo, dbo.Produit.DebutPromo, dbo.Produit.FinPromo, dbo.Produit.Coef1, dbo.Produit.Coef2, dbo.Produit.Photo, 
                      dbo.Produit.CreateDate, dbo.Produit.LastModifiedDate, dbo.Produit.KeyWords, dbo.Produit.bUseInfoUnite, dbo.Produit.Condit, dbo.Produit.CleArchiveColisage, 
                      dbo.Produit.CleDCI, dbo.Produit.ClePresentation, dbo.Produit.Dosage, dbo.Produit.N_ENREGISTREMENT, dbo.bsQteProduit.QuantiteProduit, 
                      dbo.FamilleArticle.Hierarchy, dbo.FamilleArticle.FamilleArticle, dbo.Dico.ClePresentation AS Expr1, dbo.Dico.CleLabo
FROM         dbo.FamilleArticle INNER JOIN
                      dbo.Dico RIGHT OUTER JOIN
                      dbo.bsQteProduit RIGHT OUTER JOIN
                      dbo.Produit ON dbo.bsQteProduit.CleProduit = dbo.Produit.CleProduit ON dbo.Dico.CleDico = dbo.Produit.CleDico ON 
                      dbo.FamilleArticle.CleFamilleArticle = dbo.Produit.CleFamilleArticle




GO
/****** Object:  View [dbo].[JCMDCL]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JCMDCL]
AS
SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT + 0 AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, 
                        TotalPPA, Commercial, Vendeur, Remise, RemisePourcent, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, 
                        CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, CleUserAss, Invisible, MontantBrute, RemisePourcent2, Remise2, bDoc, bPsycho, bControle, CleStatutTiers, CleSolvabilite, RemiseApp, 
                        RemiseAvf, CleUserActuel
FROM          dbo.JournalEffet
WHERE      (CleTypeEffet = 4)
ORDER BY CleEffet DESC
GO
/****** Object:  View [dbo].[JSCOM]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JSCOM]
AS
SELECT      TOP (100) PERCENT CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, Montant_HT + 0 AS MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, 
                        TotalPPA, Commercial, Vendeur, CASE WHEN bRemise = 0 AND CleTypeEffet IN (10, 12) THEN 0 ELSE Remise END AS Remis, CASE WHEN bRemise = 0 AND CleTypeEffet IN (10, 12) 
                        THEN 0 ELSE RemisePourcent END AS RemisPourcent, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, Cloture, 
                        CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, MontantCagnote, PayementCagnote, ResteCag, CleUserAss, Invisible, MontantBrute, CASE WHEN bRemise2 = 0 AND CleTypeEffet IN (10, 
                        12) THEN 0 ELSE Remise2 END AS Remis2, CASE WHEN bRemise2 = 0 AND CleTypeEffet IN (10, 12) THEN 0 ELSE RemisePourcent2 END AS RemisPourcent2, bDoc, Préparateur, Contrôleur, 
                        bPsycho, bControle, CleStatutTiers, CleSolvabilite, colisa, CleUserActuel
FROM          dbo.JournalEffet
WHERE      (CleTypeEffet IN (9, 10, 11, 12))
ORDER BY CleEffet DESC
GO
/****** Object:  View [dbo].[JCAGNOTE]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JCAGNOTE]
AS
SELECT      CleEffet, CleTypeEffet, Reference, Date, Date2, CodeTiers, RaisonSociale, MontantHT, MonantTTC, Mode, Payement, Reste, Timbre, TotalTVA, TotalSHP, TotalPPA, Commercial, Vendeur, Remis, 
                        RemisePourcent, RemisePourcent2, Remis2, bRemise, bRemise2, NetHT, CategorieEffet, Name, Depot, EtatEffet, CategorieTiers, Vehicule, TypeTiers, FamilleTiers, Region, Wilaya, Associe, 
                        Cloture, CleEntreprise, CleTiers, CleCategorieEffet, CleUser, CleCommercial, CleMode, CleDepot, CleVehicule, CleVendeur, CleEtatEffet, CleTypeTiers, CleFamilleTiers, CleWilaya, CleRegion, 
                        CleCategorieTiers, CleTransaction, Couleur, CouleurEtat, MontantCagnote, PayementCagnote, CleUserAss, bCagnote, TAP, NetCagnotte, ResteCagnote, RemiseCagnote, PayementUG, 
                        PayementRemise, PayementRemise2, CleStatutTiers, CleSolvabilite, CleUserActuel, Remis13, Remis3
FROM          dbo.JCAGNOTEX
WHERE      (NetCagnotte > 0)
GO
/****** Object:  View [dbo].[__CptBalance]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[__CptBalance]
AS
SELECT DISTINCT dbo.DetailEcriture.Compte, dbo.[Plan].NbCompte, dbo.[Plan].Libelle
FROM          dbo.DetailEcriture INNER JOIN
                        dbo.[Plan] ON dbo.DetailEcriture.Compte = dbo.[Plan].NbCompte






GO
/****** Object:  View [dbo].[BALANCE]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BALANCE]
AS
SELECT      Compte, CONVERT(nvarchar(20), NbCompte) AS NCompte, Libelle, ODebit, OCredit, OSolde, EDebit, ECredit, ESolde, ODebit + EDebit AS TDebit, OCredit + ECredit AS TCredit, 
                        OSolde + ESolde AS TSolde
FROM          (SELECT      dbo.__CptBalance.Compte, dbo.__CptBalance.NbCompte, dbo.__CptBalance.Libelle, CASE WHEN __OuvertureBalance.SommeDebit IS NULL 
                                                THEN 0 ELSE __OuvertureBalance.SommeDebit END AS ODebit, CASE WHEN __OuvertureBalance.SommeCredit IS NULL 
                                                THEN 0 ELSE __OuvertureBalance.SommeCredit END AS OCredit, CASE WHEN __OuvertureBalance.SommeSolde IS NULL 
                                                THEN 0 ELSE __OuvertureBalance.SommeSolde END AS OSolde, CASE WHEN __ExerciceBalance.SommeDebit2 IS NULL 
                                                THEN 0 ELSE __ExerciceBalance.SommeDebit2 END AS EDebit, CASE WHEN __ExerciceBalance.SommeCredit2 IS NULL 
                                                THEN 0 ELSE __ExerciceBalance.SommeCredit2 END AS ECredit, CASE WHEN __ExerciceBalance.SommeSolde2 IS NULL 
                                                THEN 0 ELSE __ExerciceBalance.SommeSolde2 END AS ESolde
                        FROM           dbo.__CptBalance LEFT OUTER JOIN
                                                    (SELECT      dbo.DetailEcriture.Compte, SUM(dbo.DetailEcriture.Debit) AS SommeDebit2, SUM(dbo.DetailEcriture.Credit) AS SommeCredit2, SUM(dbo.DetailEcriture.Debit) 
                                                                              - SUM(dbo.DetailEcriture.Credit) AS SommeSolde2
                                                      FROM           dbo.DetailEcriture INNER JOIN
                                                                              dbo.Ecriture ON dbo.DetailEcriture.CleEcriture = dbo.Ecriture.CleEcriture
                                                      WHERE       (dbo.Ecriture.CleJournal <> 1) AND (dbo.Ecriture.Date >= '01-01-2015') AND (dbo.Ecriture.Date <= '31-12-2015')
                                                      GROUP BY dbo.DetailEcriture.Compte) AS __ExerciceBalance ON dbo.__CptBalance.Compte = __ExerciceBalance.Compte LEFT OUTER JOIN
                                                    (SELECT      DetailEcriture_1.Compte, SUM(DetailEcriture_1.Debit) AS SommeDebit, SUM(DetailEcriture_1.Credit) AS SommeCredit, SUM(DetailEcriture_1.Debit) 
                                                                              - SUM(DetailEcriture_1.Credit) AS SommeSolde
                                                      FROM           dbo.DetailEcriture AS DetailEcriture_1 INNER JOIN
                                                                              dbo.Ecriture AS Ecriture_1 ON DetailEcriture_1.CleEcriture = Ecriture_1.CleEcriture
                                                      WHERE       (Ecriture_1.CleJournal = 1)
                                                      GROUP BY DetailEcriture_1.Compte) AS __OuvertureBalance ON dbo.__CptBalance.Compte = __OuvertureBalance.Compte) AS balances




GO
/****** Object:  View [dbo].[bsReglementAll]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[bsReglementAll]
AS
SELECT      CleEffet, CleTypeEffet, Payement AS Reglement, MonantTTC - Payement AS ResteAPayer, MonantTTC
FROM          dbo.EffetAll
GO
/****** Object:  View [dbo].[RealisationPalier]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[RealisationPalier]
AS
SELECT      TOP (100) PERCENT dbo.ConventionPalier.CleConvention, 'Palier ' AS Palier, dbo.ConventionPalier.Gamme, dbo.ConventionPalier.Montant, dbo.ConventionPalier.Ristourne, 
                        Real.Mont / dbo.ConventionPalier.Montant * 100 AS Real, Real.Mont, Real.Mont * dbo.ConventionPalier.Ristourne / 100 AS Rist, dbo.ConventionPalier.bObjectif, 
                        dbo.ConventionPalier.RistourneSupp
FROM          dbo.ConventionPalier LEFT OUTER JOIN
                            (SELECT      CleConvention, SUM(Montant) AS Mont, Gamme
                              FROM           dbo.RealisationConvention
                              GROUP BY CleConvention, Gamme
                              UNION
                              SELECT      Convention_1.CleConvention, SUM(CASE WHEN EffetAll.CleTypeEffet = 6 THEN EffetAll.MonantTTC WHEN EffetAll.CleTypeEffet IN (8, 1) THEN - EffetAll.MonantTTC END) 
                                                      AS MontantTTC, '' AS Gam
                              FROM          dbo.EffetAll INNER JOIN
                                                      dbo.Convention AS Convention_1 ON dbo.EffetAll.CleTiers = Convention_1.CleTiers
                              WHERE      (dbo.EffetAll.Date BETWEEN Convention_1.Debut AND Convention_1.Fin) AND (dbo.EffetAll.CleTypeEffet IN (6, 8, 1)) AND (Convention_1.Suivi = 0) AND 
                                                      (dbo.EffetAll.bUseTauxRemise = 1)
                              GROUP BY dbo.EffetAll.CleTiers, Convention_1.CleConvention) AS Real ON dbo.ConventionPalier.CleConvention = Real.CleConvention AND dbo.ConventionPalier.Gamme = Real.Gamme
ORDER BY dbo.ConventionPalier.Gamme
GO
/****** Object:  View [dbo].[__ExerciceBalance]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[__ExerciceBalance]
AS
SELECT      dbo.DetailEcriture.Compte, SUM(dbo.DetailEcriture.Debit) AS SommeDebit2, SUM(dbo.DetailEcriture.Credit) AS SommeCredit2, SUM(dbo.DetailEcriture.Debit) - SUM(dbo.DetailEcriture.Credit) 
                        AS SommeSolde2
FROM          dbo.DetailEcriture INNER JOIN
                        dbo.Ecriture ON dbo.DetailEcriture.CleEcriture = dbo.Ecriture.CleEcriture
WHERE      (dbo.Ecriture.CleJournal <> 1)
GROUP BY dbo.DetailEcriture.Compte






GO
/****** Object:  View [dbo].[__OuvertureBalance]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[__OuvertureBalance]
AS
SELECT      dbo.DetailEcriture.Compte, SUM(dbo.DetailEcriture.Debit) AS SommeDebit, SUM(dbo.DetailEcriture.Credit) AS SommeCredit, SUM(dbo.DetailEcriture.Debit) - SUM(dbo.DetailEcriture.Credit) 
                        AS SommeSolde
FROM          dbo.DetailEcriture INNER JOIN
                        dbo.Ecriture ON dbo.DetailEcriture.CleEcriture = dbo.Ecriture.CleEcriture
WHERE      (dbo.Ecriture.CleJournal = 1)
GROUP BY dbo.DetailEcriture.Compte






GO
/****** Object:  View [dbo].[__SCptBalance2]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[__SCptBalance2]
AS
SELECT DISTINCT dbo.DetailEcriture.SousCompte, dbo.Tiers.CodeTiers, dbo.Tiers.RaisonSociale
FROM          dbo.DetailEcriture INNER JOIN
                        dbo.Tiers ON dbo.DetailEcriture.SousCompte = dbo.Tiers.CodeTiers
WHERE      (LEN(dbo.Tiers.CodeTiers) > 0)





GO
/****** Object:  View [dbo].[_tiers]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[_tiers]
AS
SELECT     TOP (100) PERCENT CleTiers, RaisonSociale
FROM         dbo.Tiers
ORDER BY RaisonSociale




GO
/****** Object:  View [dbo].[bsReglement]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[bsReglement]
AS
SELECT     CleEffet, Payement AS Reglement, MonantTTC - Payement AS ResteAPayer, MonantTTC
FROM         dbo.Effet




GO
/****** Object:  View [dbo].[Client]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Client]
AS
SELECT      CleTiers, CodeTiers, RefTiers, CodeCompta, RaisonSociale, CleTypeTiers, CleFamilleTiers, Adresse, CodePostal, Ville, CleWilaya, CleRegion, AdresseLivraison, Correspondant, Tel, Mobile, Fax, 
                        EMail, WebPage, IdFiscal, NIS, RC, Article, NCompte, RIB, Remarque, Note, bLocked, LockDate, bSpecial, bAdmin, bGroupe, Solde, SoldeMax, TauxRemise, TauxMajoration, ExoTVA, bUsePMP, 
                        TarifLot, UsePromo, UseUG, CleTarif, CleModeleEcheance, CleSolvabilite, CleCategorieTiers, CleUser, CleEntreprise, CleTournee, CreateDate, LastModifiedDate, Transfered, KeyWords, Date1, 
                        Date2, Date3, bSynch, Coeff, Echeances, CleVendeur, bPoint, Point, bGrossiste, Invisible, CleUserActuel
FROM          dbo.Tiers
WHERE      (CleTypeTiers = 2)
GO
/****** Object:  View [dbo].[DetailEffetLot]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DetailEffetLot]
AS
SELECT      dbo.DetailEffet.CleDetailEffet, dbo.DetailEffet.CleEffet, dbo.DetailEffet.CleLot, dbo.DetailEffet.Offset, dbo.DetailEffet.Reference, dbo.DetailEffet.Designation, dbo.DetailEffet.PrixDevis, 
                        dbo.DetailEffet.PrixUnitaireHT, dbo.DetailEffet.TVAPourCent, dbo.DetailEffet.PrixUnitaireTTC, dbo.DetailEffet.Marge, dbo.DetailEffet.Ristourne, dbo.DetailEffet.RistournePourcent, 
                        dbo.DetailEffet.Cagnote, dbo.DetailEffet.bRistPourcent, dbo.DetailEffet.Quantite, dbo.DetailEffet.Poid, dbo.DetailEffet.Volume, dbo.DetailEffet.NbColie, dbo.DetailEffet.Colissage, 
                        dbo.DetailEffet.TailleCollie, dbo.DetailEffet.PMP, dbo.DetailEffet.OldQte, dbo.DetailEffet.FullDesignation, dbo.DetailEffet.CleParent, dbo.DetailEffet.PageBreak, dbo.DetailEffet.bNoPrint, 
                        dbo.DetailEffet.CreateDate, dbo.DetailEffet.LastModifiedDate, dbo.DetailEffet.CleDepot, dbo.Lot.CleLot AS Expr1, dbo.Lot.CleProduit, dbo.Lot.CodeLot, dbo.Lot.NLot, dbo.Lot.DateExp, 
                        dbo.Lot.PrixAchat, dbo.Lot.PrixVente, dbo.Lot.PrixVenteTTC, dbo.Lot.PrixGros, dbo.Lot.PPA, dbo.Lot.SHP, dbo.Lot.Marge AS Expr3, dbo.Lot.MargePh, dbo.Lot.MargeGros, dbo.Lot.CleStatutLot, 
                        dbo.Lot.CleMarque, dbo.Lot.Condit, dbo.Lot.Date2, dbo.Lot.CleEmplacement, dbo.DetailEffet.CleNatureTask, dbo.DetailEffet.CleEtatTask, dbo.DetailEffet.CleUser, dbo.Marque.Marque, 
                        dbo.Coefficient.Couleur, dbo.DetailEffet.Coeff, dbo.DetailEffet.CleUserCreate, dbo.DetailEffet.CleUserModify, dbo.DetailEffet.UG, dbo.DetailEffet.PrixCagnote
FROM          dbo.DetailEffet INNER JOIN
                        dbo.Lot ON dbo.DetailEffet.CleLot = dbo.Lot.CleLot LEFT OUTER JOIN
                        dbo.Coefficient ON dbo.DetailEffet.Coeff = dbo.Coefficient.Coefficient LEFT OUTER JOIN
                        dbo.Marque ON dbo.Lot.CleMarque = dbo.Marque.CleMarque
GO

/****** Object:  View [dbo].[EtatDoubleEmploi]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EtatDoubleEmploi]
AS
SELECT      derivedtbl_1.Reference, Effet_1.Date, dbo.Tiers.RaisonSociale, Effet_1.MontantHT, Effet_1.TotalTVA, Effet_1.MonantTTC
FROM          (SELECT      Reference, COUNT(CleEffet) AS nb
                        FROM           dbo.Effet
                        WHERE       (CleTypeEffet IN (6, 8))
                        GROUP BY Reference) AS derivedtbl_1 INNER JOIN
                        dbo.Effet AS Effet_1 ON derivedtbl_1.Reference = Effet_1.Reference INNER JOIN
                        dbo.Tiers ON Effet_1.CleTiers = dbo.Tiers.CleTiers
WHERE      (derivedtbl_1.nb > 1) AND (Effet_1.CleTypeEffet IN (6, 8))




GO
/****** Object:  View [dbo].[Fournisseur]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Fournisseur]
AS
SELECT      CleTiers, CodeTiers, RefTiers, CodeCompta, RaisonSociale, CleTypeTiers, CleFamilleTiers, Adresse, CodePostal, Ville, CleWilaya, CleRegion, AdresseLivraison, Correspondant, Tel, Mobile, Fax, 
                        EMail, WebPage, IdFiscal, NIS, RC, Article, NCompte, RIB, Remarque, Note, bLocked, LockDate, bSpecial, bAdmin, bGroupe, Solde, SoldeMax, TauxRemise, TauxMajoration, ExoTVA, bUsePMP, 
                        TarifLot, UsePromo, UseUG, CleTarif, CleModeleEcheance, CleSolvabilite, CleCategorieTiers, CleUser, CleEntreprise, CleTournee, CreateDate, LastModifiedDate, Transfered, KeyWords, Date1, 
                        Date2, Date3, bSynch, Coeff, Echeances, CleVendeur, bGrossiste, Invisible, CleUserActuel
FROM          dbo.Tiers
WHERE      (CleTypeTiers = 1)
GO
/****** Object:  View [dbo].[JCHARGE]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JCHARGE]
AS
SELECT      TOP (100) PERCENT dbo.EffetCharge.CleEffetCharge, dbo.EffetCharge.CleTypeEffetCharge, dbo.EffetCharge.CleTiers, dbo.EffetCharge.CleEntreprise, dbo.EffetCharge.Reference, 
                        dbo.EffetCharge.Date, dbo.EffetCharge.Date2, dbo.EffetCharge.MontantHT, dbo.EffetCharge.Remise, dbo.EffetCharge.TotalTVA, dbo.EffetCharge.Timbre, dbo.EffetCharge.MonantTTC, 
                        dbo.EffetCharge.Payement, dbo.EffetCharge.MonantTTC - dbo.EffetCharge.Payement AS Reste, dbo.Tiers.CodeTiers, dbo.Tiers.RaisonSociale, dbo.Mode.Mode, dbo.[User].Name, 
                        dbo.CategorieTiers.CategorieTiers, dbo.TypeTiers.TypeTiers, dbo.FamilleTiers.FamilleTiers, dbo.Region.Region, dbo.Wilaya.Wilaya, dbo.Tiers.CleTypeTiers, dbo.Tiers.CleFamilleTiers, 
                        dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, dbo.EffetCharge.Cloture, dbo.EffetCharge.CleUser, dbo.EffetCharge.CleMode, dbo.EffetCharge.CreateDate, 
                        dbo.EffetCharge.LastModifiedDate, dbo.EffetCharge.CleUserModify, dbo.EffetCharge.CleTVA, dbo.EffetCharge.Invisible, CASE WHEN Doc.CleEffetCharge IS NULL THEN 0 ELSE 1 END AS bDoc, 
                        CASE WHEN Compta.CleJour IS NULL THEN 0 ELSE 1 END AS bCompta, dbo.CategorieCharge.CategorieCharge, dbo.CategorieCharge.CleCategorieCharge, dbo.EtatEffet.CleEtatEffet, 
                        dbo.EtatEffet.Couleur AS CouleurEtat, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, dbo.Tiers.CleUserActuel
FROM          dbo.Region RIGHT OUTER JOIN
                        dbo.Mode RIGHT OUTER JOIN
                        dbo.Tiers RIGHT OUTER JOIN
                        dbo.EtatEffet RIGHT OUTER JOIN
                        dbo.EffetCharge ON dbo.EtatEffet.CleEtatEffet = dbo.EffetCharge.CleEtatEffetCharge LEFT OUTER JOIN
                        dbo.CategorieCharge ON dbo.EffetCharge.CleCategorieCharge = dbo.CategorieCharge.CleCategorieCharge ON dbo.Tiers.CleTiers = dbo.EffetCharge.CleTiers ON 
                        dbo.Mode.CleMode = dbo.EffetCharge.CleMode LEFT OUTER JOIN
                        dbo.[User] ON dbo.EffetCharge.CleUser = dbo.[User].CleUser LEFT OUTER JOIN
                        dbo.FamilleTiers ON dbo.Tiers.CleFamilleTiers = dbo.FamilleTiers.CleFamilleTiers LEFT OUTER JOIN
                        dbo.Wilaya ON dbo.Tiers.CleWilaya = dbo.Wilaya.CleWilaya ON dbo.Region.CleRegion = dbo.Tiers.CleRegion LEFT OUTER JOIN
                        dbo.TypeTiers ON dbo.Tiers.CleTypeTiers = dbo.TypeTiers.CleTypeTiers LEFT OUTER JOIN
                        dbo.CategorieTiers ON dbo.Tiers.CleCategorieTiers = dbo.CategorieTiers.CleCategorieTiers LEFT OUTER JOIN
                            (SELECT      CleEffetCharge
                              FROM           dbo.DocEffetCharge
                              GROUP BY CleEffetCharge) AS Doc ON dbo.EffetCharge.CleEffetCharge = Doc.CleEffetCharge LEFT OUTER JOIN
                            (SELECT      CleJour
                              FROM           dbo.Ecriture
                              WHERE       (Jour = 3)
                              GROUP BY CleJour) AS Compta ON dbo.EffetCharge.CleEffetCharge = Compta.CleJour
GO
/****** Object:  View [dbo].[JCOMPTE]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JCOMPTE]
AS
SELECT     dbo.Entreprise.RaisonSociale, dbo.Compte.Compte, dbo.Compte.CodeCompta, dbo.Compte.DateCreation, 
                      CASE Compte.bCaisse WHEN 1 THEN 'Caisse' ELSE 'Banque' END AS Type, dbo.Compte.Solde, dbo.Compte.RIB, dbo.Compte.Banque, dbo.Compte.Agence, 
                      dbo.Compte.CleCompte
FROM         dbo.Compte INNER JOIN
                      dbo.Entreprise ON dbo.Compte.CleEntreprise = dbo.Entreprise.CleEntreprise




GO
/****** Object:  View [dbo].[JCPT]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JCPT]
AS
SELECT      TOP (100) PERCENT CONVERT(nvarchar(20), dbo.[Plan].NbCompte) AS NCompte, dbo.[Plan].Libelle, dbo.[Plan].LibelleArabe, CASE bSousCompte WHEN 1 THEN 'Détail' ELSE 'Principal' END AS Type,
                         dbo.NatureCompte.NatureCompte, dbo.CategorieCompte.CategorieCompte, dbo.StatutCompte.StatutCompte
FROM          dbo.[Plan] LEFT OUTER JOIN
                        dbo.CategorieCompte ON dbo.[Plan].CleCategorie = dbo.CategorieCompte.CleCategorieCompte LEFT OUTER JOIN
                        dbo.StatutCompte ON dbo.[Plan].CleStatut = dbo.StatutCompte.CleStatutCompte LEFT OUTER JOIN
                        dbo.NatureCompte ON dbo.[Plan].CleNature = dbo.NatureCompte.CleNatureCompte
ORDER BY dbo.[Plan].NbCompte




GO
/****** Object:  View [dbo].[JECRITURE]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JECRITURE]
AS
SELECT      dbo.Ecriture.CleEcriture, dbo.Ecriture.Reference, dbo.Ecriture.Date, dbo.Ecriture.NbPiece, dbo.Journal.Libelle, dbo.Classeur.Classeur, dbo.Ecriture.Debit, dbo.Ecriture.Credit, User_1.Name, 
                        dbo.[User].Name AS Name2, dbo.Journal.CleJournal, dbo.Classeur.CleClasseur, User_1.CleUser, YEAR(dbo.Ecriture.Date) AS exo, Doc.doc
FROM          dbo.Ecriture LEFT OUTER JOIN
                        dbo.[User] ON dbo.Ecriture.CleUserModified = dbo.[User].CleUser LEFT OUTER JOIN
                        dbo.[User] AS User_1 ON dbo.Ecriture.CleUser = User_1.CleUser LEFT OUTER JOIN
                        dbo.Journal ON dbo.Ecriture.CleJournal = dbo.Journal.CleJournal LEFT OUTER JOIN
                        dbo.Classeur ON dbo.Ecriture.CleClasseur = dbo.Classeur.CleClasseur LEFT OUTER JOIN
                            (SELECT      MAX(NbDoc) AS doc, CleEcriture
                              FROM           dbo.DetailEcriture
                              GROUP BY CleEcriture) AS Doc ON dbo.Ecriture.CleEcriture = Doc.CleEcriture




GO
/****** Object:  View [dbo].[JECRITURE2]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JECRITURE2]
AS
SELECT      TOP (100) PERCENT dbo.Ecriture.CleEcriture, dbo.DetailEcriture.CleDetailEcriture, dbo.[Plan].ClePlan, dbo.SousCompte.CleSousCompte, 
                        dbo.Journal.Libelle + ' : ' + CAST(dbo.Ecriture.Reference AS varchar(30)) AS Pièce, dbo.Ecriture.Reference, dbo.Ecriture.Date, dbo.Ecriture.NbPiece, dbo.Journal.Libelle, dbo.Classeur.Classeur, 
                        CONVERT(nvarchar(20), dbo.[Plan].NbCompte) + ' (' + dbo.[Plan].Libelle + ')' AS NbCpt, dbo.SousCompte.NbCompte + ' (' + dbo.SousCompte.Libelle + ')' AS NbSousCpt, 
                        dbo.DetailEcriture.Libelle AS LibelleEcriture, dbo.DetailEcriture.NbDoc, dbo.NatureCompte.NatureCompte, dbo.CategorieCompte.CategorieCompte, dbo.StatutCompte.StatutCompte, 
                        dbo.DetailEcriture.Debit, dbo.DetailEcriture.Credit, dbo.Classeur.CleClasseur, dbo.Journal.CleJournal, dbo.NatureCompte.CleNatureCompte, dbo.CategorieCompte.CleCategorieCompte, 
                        dbo.StatutCompte.CleStatutCompte, dbo.DetailEcriture.Debit - dbo.DetailEcriture.Credit AS Solde, dbo.SousCompte.Libelle AS LibelleSCPT, YEAR(dbo.Ecriture.Date) AS exo, dbo.[Plan].NbCompte, 
                        dbo.SousCompte.NbCompte AS NbSousCompte
FROM          dbo.Ecriture INNER JOIN
                        dbo.DetailEcriture ON dbo.Ecriture.CleEcriture = dbo.DetailEcriture.CleEcriture INNER JOIN
                        dbo.[Plan] ON dbo.DetailEcriture.Compte = dbo.[Plan].NbCompte LEFT OUTER JOIN
                        dbo.SousCompte ON dbo.[Plan].ClePlan = dbo.SousCompte.CleCompte LEFT OUTER JOIN
                        dbo.NatureCompte ON dbo.[Plan].CleNature = dbo.NatureCompte.CleNatureCompte LEFT OUTER JOIN
                        dbo.StatutCompte ON dbo.[Plan].CleStatut = dbo.StatutCompte.CleStatutCompte LEFT OUTER JOIN
                        dbo.CategorieCompte ON dbo.[Plan].CleCategorie = dbo.CategorieCompte.CleCategorieCompte LEFT OUTER JOIN
                        dbo.Journal ON dbo.Ecriture.CleJournal = dbo.Journal.CleJournal LEFT OUTER JOIN
                        dbo.Classeur ON dbo.Ecriture.CleClasseur = dbo.Classeur.CleClasseur
ORDER BY dbo.Ecriture.CleEcriture DESC




GO
/****** Object:  View [dbo].[JECRITURE3]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JECRITURE3]
AS
SELECT      TOP (100) PERCENT dbo.Ecriture.CleEcriture, dbo.DetailEcriture.CleDetailEcriture, dbo.[Plan].ClePlan, Tier.CleTiers AS CleSousCompte, 
                        dbo.Journal.Libelle + ' : ' + CAST(dbo.Ecriture.Reference AS varchar(30)) AS Pièce, dbo.Ecriture.Reference, dbo.Ecriture.Date, dbo.Ecriture.NbPiece, dbo.Journal.Libelle, dbo.Classeur.Classeur, 
                        CONVERT(nvarchar(20), dbo.[Plan].NbCompte) + ' (' + dbo.[Plan].Libelle + ')' AS NbCpt, Tier.CodeTiers + ' (' + Tier.RaisonSociale + ')' AS NbSousCpt, dbo.DetailEcriture.Libelle AS LibelleEcriture, 
                        dbo.DetailEcriture.NbDoc, dbo.NatureCompte.NatureCompte, dbo.CategorieCompte.CategorieCompte, dbo.StatutCompte.StatutCompte, dbo.DetailEcriture.Debit, dbo.DetailEcriture.Credit, 
                        dbo.Classeur.CleClasseur, dbo.Journal.CleJournal, dbo.NatureCompte.CleNatureCompte, dbo.CategorieCompte.CleCategorieCompte, dbo.StatutCompte.CleStatutCompte, 
                        dbo.DetailEcriture.Debit - dbo.DetailEcriture.Credit AS Solde, Tier.RaisonSociale AS LibelleSCPT, YEAR(dbo.Ecriture.Date) AS exo, dbo.[Plan].NbCompte, Tier.CodeTiers AS NbSousCompte
FROM          dbo.Ecriture INNER JOIN
                        dbo.DetailEcriture ON dbo.Ecriture.CleEcriture = dbo.DetailEcriture.CleEcriture INNER JOIN
                        dbo.[Plan] ON dbo.DetailEcriture.Compte = dbo.[Plan].NbCompte LEFT OUTER JOIN
                            (SELECT      CleTiers, CodeTiers, RefTiers, CodeCompta, RaisonSociale, CleTypeTiers, CleFamilleTiers, Adresse, CodePostal, Ville, CleWilaya, CleRegion, AdresseLivraison, Correspondant, Tel, 
                                                      Mobile, Fax, EMail, WebPage, IdFiscal, NIS, RC, Article, NCompte, RIB, Remarque, Note, bLocked, LockDate, bSpecial, bAdmin, bGrossiste, bGroupe, Solde, SoldeMax, TauxRemise, 
                                                      TauxMajoration, ExoTVA, bUsePMP, TarifLot, UsePromo, UseUG, CleTarif, CleModeleEcheance, CleSolvabilite, CleCategorieTiers, CleUser, CleEntreprise, CleTournee, CreateDate, 
                                                      LastModifiedDate, Transfered, KeyWords, Date1, Date2, Date3, bSynch, Coeff, Echeances, CleVendeur, bPoint, Point, bPrixVente, Invisible, CleMode, Ratio, UseUGAchat, 
                                                      bRemiseAchat, beneficieRemiseAchat, bEcheance, CleCompte
                              FROM           dbo.Tiers
                              WHERE       (LEN(CodeTiers) > 0)) AS Tier ON dbo.DetailEcriture.SousCompte = Tier.CodeTiers LEFT OUTER JOIN
                        dbo.NatureCompte ON dbo.[Plan].CleNature = dbo.NatureCompte.CleNatureCompte LEFT OUTER JOIN
                        dbo.StatutCompte ON dbo.[Plan].CleStatut = dbo.StatutCompte.CleStatutCompte LEFT OUTER JOIN
                        dbo.CategorieCompte ON dbo.[Plan].CleCategorie = dbo.CategorieCompte.CleCategorieCompte LEFT OUTER JOIN
                        dbo.Journal ON dbo.Ecriture.CleJournal = dbo.Journal.CleJournal LEFT OUTER JOIN
                        dbo.Classeur ON dbo.Ecriture.CleClasseur = dbo.Classeur.CleClasseur
ORDER BY dbo.Ecriture.CleEcriture DESC




GO
/****** Object:  View [dbo].[JINVEST]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JINVEST]
AS
SELECT      dbo.Investissement.Code, dbo.Investissement.Libelle, dbo.TypeInvestissement.TypeInvestissement, dbo.Investissement.Quantite, dbo.Investissement.DateMiseService, 
                        dbo.AffectationInvestissement.AffectationInvestissement, dbo.Investissement.DateAquisition, dbo.TypeAquisition.TypeAquisition, dbo.Investissement.Valeur, 
                        CASE WHEN Amortissements.ValeurAmort IS NULL THEN 0 ELSE Amortissements.ValeurAmort END AS ValeurAmorti, dbo.Investissement.Valeur - (CASE WHEN Amortissements.ValeurAmort IS NULL
                         THEN 0 ELSE Amortissements.ValeurAmort END) AS Net, CONVERT(nvarchar(20), dbo.[Plan].NbCompte) AS NCompte, CONVERT(nvarchar(20), Plan_1.NbCompte) AS NbCompteAmortissement, 
                        CONVERT(nvarchar(20), Plan_2.NbCompte) AS NbCompteDotation, dbo.Investissement.DateSortie, dbo.TypeSortie.TypeSortie, dbo.Investissement.TauxAmortissement, 
                        dbo.TypeAmortissement.TypeAmortissement, dbo.TypeAmortissement.CleTypeAmortissement, dbo.TypeSortie.CleTypeSortie, dbo.TypeInvestissement.CleTypeInvestissement, 
                        dbo.TypeAquisition.CleTypeAquisition, dbo.Investissement.CleInvestissement
FROM          dbo.Investissement LEFT OUTER JOIN
                        dbo.[Plan] AS Plan_2 ON dbo.Investissement.CompteDotation = Plan_2.NbCompte LEFT OUTER JOIN
                        dbo.[Plan] AS Plan_1 ON dbo.Investissement.CompteAmortissement = Plan_1.NbCompte LEFT OUTER JOIN
                        dbo.[Plan] ON dbo.Investissement.Compte = dbo.[Plan].NbCompte LEFT OUTER JOIN
                        dbo.AffectationInvestissement ON dbo.Investissement.CleAffectation = dbo.AffectationInvestissement.CleAffectationInvestissement LEFT OUTER JOIN
                        dbo.TypeSortie ON dbo.Investissement.CleTypeSortie = dbo.TypeSortie.CleTypeSortie LEFT OUTER JOIN
                        dbo.TypeAmortissement ON dbo.Investissement.CleTypeAmortissement = dbo.TypeAmortissement.CleTypeAmortissement LEFT OUTER JOIN
                        dbo.TypeInvestissement ON dbo.Investissement.CleTypeInvestissement = dbo.TypeInvestissement.CleTypeInvestissement LEFT OUTER JOIN
                        dbo.TypeAquisition ON dbo.Investissement.CleTypeAquisition = dbo.TypeAquisition.CleTypeAquisition LEFT OUTER JOIN
                            (SELECT      CleInvestissement, SUM(Montant) AS ValeurAmort
                              FROM           dbo.Amortissement
                              GROUP BY CleInvestissement) AS Amortissements ON dbo.Investissement.CleInvestissement = Amortissements.CleInvestissement




GO
/****** Object:  View [dbo].[JournalPaye]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JournalPaye]
AS
SELECT      dbo.UserInfo.CleUser, dbo.UpPaye.Periode, dbo.UserInfo.Code, dbo.UserInfo.NomComplet, dbo.UserInfo.Prenom, dbo.UpFonction.Fonction, dbo.UpDetailPaye.Montant, dbo.UpPaye.bSpecial
FROM          dbo.UpFonction RIGHT OUTER JOIN
                        dbo.UserInfo INNER JOIN
                        dbo.UpRubrique INNER JOIN
                        dbo.UpDetailPaye INNER JOIN
                        dbo.UpPaye ON dbo.UpDetailPaye.ClePaye = dbo.UpPaye.ClePaye ON dbo.UpRubrique.CleRubrique = dbo.UpDetailPaye.CleRubrique ON dbo.UserInfo.CleUser = dbo.UpPaye.CleUser ON 
                        dbo.UpFonction.CleFonction = dbo.UpPaye.CleFonction
WHERE      (dbo.UpRubrique.Code = '999')

GO
/****** Object:  View [dbo].[JournalPayeDetail]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JournalPayeDetail]
AS
SELECT      dbo.UserInfo.CleUser, Paie.Periode, Paie.CleEntreprise, dbo.UserInfo.NomComplet, dbo.UserInfo.Prenom, Paie.Fonction, dbo.UserInfo.Nenfant, Paie.Base, Paie.Cotisable, Paie.Imposable, 
                        Paie.ISRetenue, Paie.RSS, Paie.RIRG, Paie.AutreVers, Paie.AutreRet, Paie.Base + Paie.Cotisable - Paie.ISRetenue AS SalairePoste, 
                        Paie.Base + Paie.Cotisable + Paie.Imposable - Paie.ISRetenue AS SalaireBrut, Paie.Base + Paie.Cotisable + Paie.Imposable - Paie.ISRetenue - Paie.RSS AS SalaireNetImp, 
                        Paie.Base + Paie.Cotisable + Paie.Imposable - Paie.ISRetenue - Paie.RSS - Paie.RIRG + Paie.AutreVers - Paie.AutreRet AS Net, Paie.bSpecial
FROM          (SELECT      dbo.UpPaye.CleUser, dbo.UpPaye.Periode, dbo.UpPaye.CleEntreprise, dbo.UpPaye.bSpecial, dbo.UpFonction.Fonction, 
                                                SUM(CASE WHEN Calcul = 0 THEN UpDetailPaye.Montant ELSE 0 END) AS Base, SUM(CASE WHEN UpRubrique.bSS = 1 AND Calcul IN (1, 4) AND 
                                                bPositive = 1 THEN UpDetailPaye.Montant ELSE 0 END) AS Cotisable, SUM(CASE WHEN UpRubrique.bSS = 0 AND UpRubrique.bIRG = 1 AND Calcul IN (1, 4) AND 
                                                bPositive = 1 THEN UpDetailPaye.Montant ELSE 0 END) AS Imposable, SUM(CASE WHEN UpRubrique.bSS = 1 AND Calcul IN (1, 4) AND 
                                                bPositive = 0 THEN UpDetailPaye.Montant ELSE 0 END) AS ISRetenue, SUM(CASE WHEN Calcul = 2 THEN UpDetailPaye.Montant ELSE 0 END) AS RSS, 
                                                SUM(CASE WHEN Calcul = 3 THEN UpDetailPaye.Montant ELSE 0 END) AS RIRG, SUM(CASE WHEN (UpRubrique.bIRG = 0 AND UpRubrique.bSS = 0) AND Calcul IN (1, 4) AND 
                                                bPositive = 1 THEN UpDetailPaye.Montant ELSE 0 END) AS AutreVers, SUM(CASE WHEN UpRubrique.bSS = 0 AND Calcul IN (1, 4) AND 
                                                bPositive = 0 THEN UpDetailPaye.Montant ELSE 0 END) AS AutreRet
                        FROM           dbo.UpPaye INNER JOIN
                                                dbo.UpDetailPaye ON dbo.UpPaye.ClePaye = dbo.UpDetailPaye.ClePaye LEFT OUTER JOIN
                                                dbo.UpRubrique ON dbo.UpDetailPaye.CleRubrique = dbo.UpRubrique.CleRubrique LEFT OUTER JOIN
                                                dbo.UpFonction ON dbo.UpPaye.CleFonction = dbo.UpFonction.CleFonction
                        GROUP BY dbo.UpPaye.CleUser, dbo.UpPaye.Periode, dbo.UpPaye.CleEntreprise, dbo.UpPaye.bSpecial, dbo.UpFonction.Fonction) AS Paie INNER JOIN
                        dbo.UserInfo ON Paie.CleUser = dbo.UserInfo.CleUser
GO
/****** Object:  View [dbo].[JournalPayeDetailGroup]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[JournalPayeDetailGroup]
AS
SELECT      dbo.UserInfo.CleUser, Paie.CleEntreprise, dbo.UserInfo.NomComplet, dbo.UserInfo.Prenom, Paie.Fonction, dbo.UserInfo.Nenfant, Paie.Base AS SalaireBase, Paie.Cotisable, Paie.Imposable, 
                        Paie.ISRetenue, Paie.RSS, Paie.RIRG, Paie.AutreVers, Paie.AutreRet, Paie.Base + Paie.Cotisable - Paie.ISRetenue AS SalairePoste, 
                        Paie.Base + Paie.Cotisable + Paie.Imposable - Paie.ISRetenue AS SalaireBrut, Paie.Base + Paie.Cotisable + Paie.Imposable - Paie.ISRetenue - Paie.RSS AS SalaireNetImp, 
                        Paie.Base + Paie.Cotisable + Paie.Imposable - Paie.ISRetenue - Paie.RSS - Paie.RIRG + Paie.AutreVers - Paie.AutreRet AS Net, Paie.Periode
FROM          (SELECT      dbo.UpPaye.CleUser, MAX(dbo.UpPaye.Periode) AS Periode, CONVERT(varchar(7), dbo.UpPaye.Periode, 126) AS Period, dbo.UpPaye.CleEntreprise, dbo.UpFonction.Fonction, 
                                                SUM(CASE WHEN Calcul = 0 THEN UpDetailPaye.Montant ELSE 0 END) AS Base, SUM(CASE WHEN UpRubrique.bSS = 1 AND Calcul IN (1, 4) AND 
                                                bPositive = 1 THEN UpDetailPaye.Montant ELSE 0 END) AS Cotisable, SUM(CASE WHEN UpRubrique.bSS = 0 AND UpRubrique.bIRG = 1 AND Calcul IN (1, 4) AND 
                                                bPositive = 1 THEN UpDetailPaye.Montant ELSE 0 END) AS Imposable, SUM(CASE WHEN UpRubrique.bSS = 1 AND Calcul IN (1, 4) AND 
                                                bPositive = 0 THEN UpDetailPaye.Montant ELSE 0 END) AS ISRetenue, SUM(CASE WHEN Calcul = 2 THEN UpDetailPaye.Montant ELSE 0 END) AS RSS, 
                                                SUM(CASE WHEN Calcul = 3 THEN UpDetailPaye.Montant ELSE 0 END) AS RIRG, SUM(CASE WHEN (UpRubrique.bIRG = 0 AND UpRubrique.bSS = 0) AND Calcul IN (1, 4) AND 
                                                bPositive = 1 THEN UpDetailPaye.Montant ELSE 0 END) AS AutreVers, SUM(CASE WHEN UpRubrique.bSS = 0 AND Calcul IN (1, 4) AND 
                                                bPositive = 0 THEN UpDetailPaye.Montant ELSE 0 END) AS AutreRet
                        FROM           dbo.UpPaye INNER JOIN
                                                dbo.UpDetailPaye ON dbo.UpPaye.ClePaye = dbo.UpDetailPaye.ClePaye LEFT OUTER JOIN
                                                dbo.UpRubrique ON dbo.UpDetailPaye.CleRubrique = dbo.UpRubrique.CleRubrique LEFT OUTER JOIN
                                                dbo.UpFonction ON dbo.UpPaye.CleFonction = dbo.UpFonction.CleFonction
                        GROUP BY dbo.UpPaye.CleUser, CONVERT(varchar(7), dbo.UpPaye.Periode, 126), dbo.UpPaye.CleEntreprise, dbo.UpFonction.Fonction) AS Paie INNER JOIN
                        dbo.UserInfo ON Paie.CleUser = dbo.UserInfo.CleUser

GO
/****** Object:  View [dbo].[JPointage]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JPointage]
AS
SELECT      CleUser, Code, dat, MIN(matin) AS matin, MAX(soir) AS soir
FROM          (SELECT      CleUser, Code, dat, CASE WHEN (bPlein = 1 AND ((heur) < '12:00:00' OR
                                                bentree = 0)) OR
                                                (bPlein = 0 AND bentree = 0) THEN (heur) ELSE NULL END AS matin, CASE WHEN (bPlein = 1 AND ((heur) > '13:00:00' OR
                                                bentree = 1)) OR
                                                (bPlein = 0 AND bentree = 1) THEN (heur) ELSE NULL END AS soir
                        FROM           (SELECT      dbo.UserInfo.CleUser, dbo.UpPointage.Code, CONVERT(varchar(10), dbo.UpPointage.Date, 103) AS dat, CONVERT(varchar(8), dbo.UpPointage.Date, 108) AS heur, 
                                                                         dbo.UpPointage.bEntree, dbo.UserInfo.bPlein
                                                 FROM           dbo.UpPointage INNER JOIN
                                                                         dbo.UserInfo ON dbo.UpPointage.Code = dbo.UserInfo.Code) AS tbl1) AS derivedtbl_1
GROUP BY CleUser, Code, dat

GO
/****** Object:  View [dbo].[JRCC]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JRCC]
AS
SELECT      TOP (100) PERCENT dbo.Effet.CleEffet, dbo.Effet.CleTypeEffet, dbo.Effet.Reference, dbo.Effet.Date, dbo.Effet.DateEtat, dbo.Effet.Date2, dbo.Tiers.CodeTiers, dbo.Tiers.RaisonSociale, 
                        dbo.Effet.MontantHT, dbo.Effet.MonantTTC, dbo.Mode.Mode, dbo.Effet.Payement, dbo.Effet.MonantTTC - dbo.Effet.Payement AS Reste, dbo.Effet.Timbre, dbo.Effet.TotalTVA, dbo.Effet.TotalSHP, 
                        dbo.Effet.TotalPPA, dbo.Effet.Remise, dbo.Effet.RemisePourcent, dbo.Effet.MontantHT + dbo.Effet.Remise AS NetHT, dbo.CategorieEffet.CategorieEffet, User_2.Name, dbo.Depot.Depot, 
                        dbo.EtatEffet.EtatEffet, dbo.CategorieTiers.CategorieTiers, dbo.Vehicule.Vehicule, dbo.TypeTiers.TypeTiers, dbo.FamilleTiers.FamilleTiers, dbo.Region.Region, dbo.Wilaya.Wilaya, 
                        dbo.Effet.Associe, dbo.Effet.Cloture, dbo.Effet.CleEntreprise, dbo.Effet.CleTiers, dbo.Effet.CleCategorieEffet, dbo.Effet.CleUser, dbo.Effet.CleCommercial, dbo.Effet.CleMode, dbo.Effet.CleDepot, 
                        dbo.Effet.CleVehicule, dbo.Effet.CleVendeur, dbo.Effet.CleEtatEffet, dbo.Tiers.CleTypeTiers, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, 
                        dbo.Effet.CleTransaction, dbo.CategorieEffet.Couleur, dbo.EtatEffet.Couleur AS CouleurEtat, dbo.Tiers.CleUser AS CleUserAss, dbo.Effet.Invisible, dbo.Effet.MontantBrute, 
                        dbo.Effet.RemisePourcent2, dbo.Effet.Remise2, dbo.Effet.Avancement, dbo.[User].Name AS Commercial, User_1.Name AS Vendeur, CASE WHEN Doc.CleEffet IS NULL THEN 0 ELSE 1 END AS bDoc, 
                        dbo.Effet.bPsycho, dbo.Effet.bControle, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, dbo.Tiers.CleUserActuel
FROM          dbo.CategorieEffet RIGHT OUTER JOIN
                        dbo.Effet LEFT OUTER JOIN
                        dbo.[User] ON dbo.Effet.CleCommercial = dbo.[User].CleUser LEFT OUTER JOIN
                        dbo.[User] AS User_1 ON dbo.Effet.CleVendeur = User_1.CleUser LEFT OUTER JOIN
                        dbo.Vehicule ON dbo.Effet.CleVehicule = dbo.Vehicule.CleVehicule LEFT OUTER JOIN
                        dbo.EtatEffet ON dbo.Effet.CleEtatEffet = dbo.EtatEffet.CleEtatEffet LEFT OUTER JOIN
                        dbo.Depot ON dbo.Effet.CleDepot = dbo.Depot.CleDepot ON dbo.CategorieEffet.CleCategorieEffet = dbo.Effet.CleCategorieEffet LEFT OUTER JOIN
                        dbo.Mode ON dbo.Effet.CleMode = dbo.Mode.CleMode LEFT OUTER JOIN
                        dbo.[User] AS User_2 ON dbo.Effet.CleUser = User_2.CleUser LEFT OUTER JOIN
                        dbo.TypeTiers RIGHT OUTER JOIN
                        dbo.Region RIGHT OUTER JOIN
                        dbo.Tiers LEFT OUTER JOIN
                        dbo.FamilleTiers ON dbo.Tiers.CleFamilleTiers = dbo.FamilleTiers.CleFamilleTiers LEFT OUTER JOIN
                        dbo.Wilaya ON dbo.Tiers.CleWilaya = dbo.Wilaya.CleWilaya ON dbo.Region.CleRegion = dbo.Tiers.CleRegion ON dbo.TypeTiers.CleTypeTiers = dbo.Tiers.CleTypeTiers LEFT OUTER JOIN
                        dbo.CategorieTiers ON dbo.Tiers.CleCategorieTiers = dbo.CategorieTiers.CleCategorieTiers ON dbo.Effet.CleTiers = dbo.Tiers.CleTiers LEFT OUTER JOIN
                            (SELECT      CleEffet
                              FROM           dbo.DocEffet
                              GROUP BY CleEffet) AS Doc ON dbo.Effet.CleEffet = Doc.CleEffet
WHERE      (dbo.Effet.CleTypeEffet = 21)
ORDER BY dbo.Effet.CleEffet
GO
/****** Object:  View [dbo].[JRCF]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JRCF]
AS
SELECT      TOP (100) PERCENT dbo.Effet.CleEffet, dbo.Effet.CleTypeEffet, dbo.Effet.Reference, dbo.Effet.Date, dbo.Effet.DateEtat, dbo.Effet.Date2, dbo.Tiers.CodeTiers, dbo.Tiers.RaisonSociale, 
                        dbo.Effet.MontantHT, dbo.Effet.MonantTTC, dbo.Mode.Mode, dbo.Effet.Payement, dbo.Effet.MonantTTC - dbo.Effet.Payement AS Reste, dbo.Effet.Timbre, dbo.Effet.TotalTVA, dbo.Effet.TotalSHP, 
                        dbo.Effet.TotalPPA, dbo.Effet.Remise, dbo.Effet.RemisePourcent, dbo.Effet.MontantHT + dbo.Effet.Remise AS NetHT, dbo.CategorieEffet.CategorieEffet, User_2.Name, dbo.Depot.Depot, 
                        dbo.EtatEffet.EtatEffet, dbo.CategorieTiers.CategorieTiers, dbo.Vehicule.Vehicule, dbo.TypeTiers.TypeTiers, dbo.FamilleTiers.FamilleTiers, dbo.Region.Region, dbo.Wilaya.Wilaya, 
                        dbo.Effet.Associe, dbo.Effet.Cloture, dbo.Effet.CleEntreprise, dbo.Effet.CleTiers, dbo.Effet.CleCategorieEffet, dbo.Effet.CleUser, dbo.Effet.CleCommercial, dbo.Effet.CleMode, dbo.Effet.CleDepot, 
                        dbo.Effet.CleVehicule, dbo.Effet.CleVendeur, dbo.Effet.CleEtatEffet, dbo.Tiers.CleTypeTiers, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, 
                        dbo.Effet.CleTransaction, dbo.CategorieEffet.Couleur, dbo.EtatEffet.Couleur AS CouleurEtat, dbo.Tiers.CleUser AS CleUserAss, dbo.Effet.Invisible, dbo.Effet.MontantBrute, 
                        dbo.Effet.RemisePourcent2, dbo.Effet.Remise2, dbo.Effet.Avancement, dbo.[User].Name AS Commercial, User_1.Name AS Vendeur, CASE WHEN Doc.CleEffet IS NULL THEN 0 ELSE 1 END AS bDoc, 
                        dbo.Effet.bPsycho, dbo.Effet.bControle, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, dbo.Tiers.CleUserActuel
FROM          dbo.Mode RIGHT OUTER JOIN
                        dbo.Effet LEFT OUTER JOIN
                        dbo.[User] AS User_1 ON dbo.Effet.CleVendeur = User_1.CleUser LEFT OUTER JOIN
                        dbo.[User] ON dbo.Effet.CleCommercial = dbo.[User].CleUser LEFT OUTER JOIN
                        dbo.Vehicule ON dbo.Effet.CleVehicule = dbo.Vehicule.CleVehicule LEFT OUTER JOIN
                        dbo.EtatEffet ON dbo.Effet.CleEtatEffet = dbo.EtatEffet.CleEtatEffet LEFT OUTER JOIN
                        dbo.Depot ON dbo.Effet.CleDepot = dbo.Depot.CleDepot LEFT OUTER JOIN
                        dbo.CategorieEffet ON dbo.Effet.CleCategorieEffet = dbo.CategorieEffet.CleCategorieEffet ON dbo.Mode.CleMode = dbo.Effet.CleMode LEFT OUTER JOIN
                        dbo.[User] AS User_2 ON dbo.Effet.CleUser = User_2.CleUser LEFT OUTER JOIN
                        dbo.TypeTiers RIGHT OUTER JOIN
                        dbo.Region RIGHT OUTER JOIN
                        dbo.Tiers LEFT OUTER JOIN
                        dbo.FamilleTiers ON dbo.Tiers.CleFamilleTiers = dbo.FamilleTiers.CleFamilleTiers LEFT OUTER JOIN
                        dbo.Wilaya ON dbo.Tiers.CleWilaya = dbo.Wilaya.CleWilaya ON dbo.Region.CleRegion = dbo.Tiers.CleRegion ON dbo.TypeTiers.CleTypeTiers = dbo.Tiers.CleTypeTiers LEFT OUTER JOIN
                        dbo.CategorieTiers ON dbo.Tiers.CleCategorieTiers = dbo.CategorieTiers.CleCategorieTiers ON dbo.Effet.CleTiers = dbo.Tiers.CleTiers LEFT OUTER JOIN
                            (SELECT      CleEffet
                              FROM           dbo.DocEffet
                              GROUP BY CleEffet) AS Doc ON dbo.Effet.CleEffet = Doc.CleEffet
WHERE      (dbo.Effet.CleTypeEffet = 20)
ORDER BY dbo.Effet.CleEffet
GO
/****** Object:  View [dbo].[JTASK]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JTASK]
AS
SELECT     dbo.Task.CleTask, dbo.Task.Ref, dbo.Task.Libelle, dbo.NatureTask.Nature, dbo.EtatTask.EtatTask, dbo.CategorieTask.CategorieTask, dbo.Tiers.RaisonSociale, 
                      dbo.Task.DateArrive, dbo.Task.DateLancement, dbo.Task.DateFinPrevue, dbo.Task.DateFin, dbo.[User].Name, User_1.Name AS Expr1, User_2.Name AS Expr2, 
                      dbo.Produit.Code, dbo.Produit.Reference, dbo.Produit.Designation, dbo.Task.Serial, dbo.Task.Priorite, dbo.FamilleTiers.FamilleTiers, 
                      dbo.CategorieTiers.CategorieTiers, dbo.Wilaya.Wilaya, dbo.Region.Region, dbo.TypeTiers.TypeTiers, dbo.Task.CleNature, dbo.Task.CleEtat, dbo.Task.CleCategorie, 
                      dbo.Task.CleTiers, dbo.Task.CleUser1, dbo.Task.CleUser2, dbo.Task.CleLot, dbo.Tiers.CleTypeTiers, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, 
                      dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, dbo.Task.bLocked, dbo.CategorieTask.Couleur
FROM         dbo.TypeTiers RIGHT OUTER JOIN
                      dbo.Tiers ON dbo.TypeTiers.CleTypeTiers = dbo.Tiers.CleTypeTiers RIGHT OUTER JOIN
                      dbo.Produit RIGHT OUTER JOIN
                      dbo.Lot ON dbo.Produit.CleProduit = dbo.Lot.CleProduit RIGHT OUTER JOIN
                      dbo.Task LEFT OUTER JOIN
                      dbo.[User] AS User_2 ON dbo.Task.CleUser2 = User_2.CleUser LEFT OUTER JOIN
                      dbo.[User] ON dbo.Task.CleUserDemandeur = dbo.[User].CleUser LEFT OUTER JOIN
                      dbo.[User] AS User_1 ON dbo.Task.CleUser1 = User_1.CleUser ON dbo.Lot.CleLot = dbo.Task.CleLot LEFT OUTER JOIN
                      dbo.CategorieTask ON dbo.Task.CleCategorie = dbo.CategorieTask.CleCategorieTask LEFT OUTER JOIN
                      dbo.NatureTask ON dbo.Task.CleNature = dbo.NatureTask.CleNatureTask LEFT OUTER JOIN
                      dbo.EtatTask ON dbo.Task.CleEtat = dbo.EtatTask.CleEtatTask ON dbo.Tiers.CleTiers = dbo.Task.CleTiers LEFT OUTER JOIN
                      dbo.Region ON dbo.Tiers.CleRegion = dbo.Region.CleRegion LEFT OUTER JOIN
                      dbo.Wilaya ON dbo.Tiers.CleWilaya = dbo.Wilaya.CleWilaya LEFT OUTER JOIN
                      dbo.CategorieTiers ON dbo.Tiers.CleCategorieTiers = dbo.CategorieTiers.CleCategorieTiers LEFT OUTER JOIN
                      dbo.FamilleTiers ON dbo.Tiers.CleFamilleTiers = dbo.FamilleTiers.CleFamilleTiers




GO
/****** Object:  View [dbo].[HistTiersAffect]    Script Date: 23/10/2024 15:11:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[HistTiersAffect]
AS
SELECT      CleTiers, CleUser, Date AS Debut, Row_Number() OVER (PARTITION BY CleTiers
ORDER BY [Date]) AS rn, CASE WHEN Lead(Date) OVER (PARTITION BY CleTiers
ORDER BY [Date]) IS NULL THEN Getdate() ELSE Lead(Date) OVER (PARTITION BY CleTiers
ORDER BY [Date]) END AS Fin
FROM          HistTiers
GO

/****** Object:  View [dbo].[JTIERS]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JTIERS]
AS
SELECT      dbo.Tiers.CleTiers, dbo.TypeTiers.CleTypeTiers, dbo.Tiers.CodeTiers, dbo.Tiers.RefTiers, dbo.Tiers.CodeCompta, dbo.Tiers.RaisonSociale, dbo.Tiers.Tel, dbo.Tiers.Fax, dbo.Tiers.Mobile, 
                        dbo.Tiers.EMail, dbo.Tiers.Correspondant, dbo.Tiers.Adresse, dbo.Tiers.Ville, dbo.Wilaya.Wilaya, dbo.Region.Region, dbo.Tiers.Echeances, dbo.FamilleTiers.FamilleTiers, 
                        dbo.CategorieTiers.CategorieTiers, dbo.Tiers.bSpecial, dbo.Tiers.Remarque, User_1.Name, dbo.Vendeur.Vendeur, dbo.Tournee.Tournee, dbo.Tiers.bLocked, dbo.Tiers.Solde, dbo.Tiers.SoldeMax, 
                        dbo.Tiers.ExoTVA, dbo.Tiers.UsePromo, dbo.Tiers.UseUG, dbo.Tiers.CleTypeTiers AS Expr1, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, 
                        dbo.Tiers.CleUser, dbo.Tiers.CleTournee, dbo.Tiers.CleVendeur, dbo.CategorieTiers.Couleur, dbo.Tiers.bGrossiste, dbo.Tiers.Invisible, dbo.Tiers.Coeff, dbo.Tiers.Ratio, 
                        CASE WHEN Doc.CleTiers IS NULL THEN 0 ELSE 1 END AS bDoc, User_2.Name AS Nom2, dbo.StatutTiers.StatutTiers, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, dbo.Solvabilite.Solvabilite, 
                        dbo.Solvabilite.Couleur AS Couleur2, CASE WHEN Doc.brc IS NULL THEN 0 ELSE brc END AS brc, CASE WHEN Doc.bnif IS NULL THEN 0 ELSE bnif END AS bnif, CASE WHEN Doc.bai IS NULL 
                        THEN 0 ELSE bai END AS bai, CASE WHEN Doc.bpin IS NULL THEN 0 ELSE bpin END AS bpin, CASE WHEN Doc.ban IS NULL THEN 0 ELSE ban END AS ban, CASE WHEN Doc.bfc IS NULL 
                        THEN 0 ELSE bfc END AS bfc, derachat.LastAchat, dbo.Tiers.SoldeCagnote2, dbo.Tiers.bRemiseTaux, dbo.[User].Name AS Nom3, dbo.Tiers.CleUser2, dbo.Tiers.CleUser3, dbo.Tiers.Transfered, 
                        dbo.Tiers.Transfered3, dbo.Tiers.CleUserActuel, User_4.Name AS NomActuel, dbo.Tiers.CreateDate, dbo.Tiers.bSynch
FROM          dbo.Tiers INNER JOIN
                        dbo.TypeTiers ON dbo.Tiers.CleTypeTiers = dbo.TypeTiers.CleTypeTiers LEFT OUTER JOIN
                        dbo.[User] ON dbo.Tiers.CleUser3 = dbo.[User].CleUser LEFT OUTER JOIN
                            (SELECT      CleTiers, MAX(Date) AS LastAchat
                              FROM           dbo.Effet
                              WHERE       (CleTypeEffet IN (9, 10))
                              GROUP BY CleTiers) AS derachat ON dbo.Tiers.CleTiers = derachat.CleTiers LEFT OUTER JOIN
                        dbo.Solvabilite ON dbo.Tiers.CleSolvabilite = dbo.Solvabilite.CleSolvabilite LEFT OUTER JOIN
                        dbo.StatutTiers ON dbo.Tiers.CleStatutTiers = dbo.StatutTiers.CleStatutTiers LEFT OUTER JOIN
                        dbo.[User] AS User_2 ON dbo.Tiers.CleUser2 = User_2.CleUser LEFT OUTER JOIN
                        dbo.FamilleTiers ON dbo.Tiers.CleFamilleTiers = dbo.FamilleTiers.CleFamilleTiers LEFT OUTER JOIN
                        dbo.Tournee ON dbo.Tiers.CleTournee = dbo.Tournee.CleTournee LEFT OUTER JOIN
                        dbo.CategorieTiers ON dbo.Tiers.CleCategorieTiers = dbo.CategorieTiers.CleCategorieTiers LEFT OUTER JOIN
                        dbo.Region ON dbo.Tiers.CleRegion = dbo.Region.CleRegion LEFT OUTER JOIN
                        dbo.Vendeur ON dbo.Tiers.CleVendeur = dbo.Vendeur.CleVendeur LEFT OUTER JOIN
                        dbo.[User] AS User_1 ON dbo.Tiers.CleUser = User_1.CleUser LEFT OUTER JOIN
                        dbo.[User] AS User_4 ON dbo.Tiers.CleUserActuel = User_4.CleUser LEFT OUTER JOIN
                        dbo.Wilaya ON dbo.Tiers.CleWilaya = dbo.Wilaya.CleWilaya LEFT OUTER JOIN
                            (SELECT      CleTiers, MAX(CASE WHEN libelle LIKE 'RC%' THEN 1 ELSE 0 END) AS brc, MAX(CASE WHEN libelle LIKE 'AI%' THEN 1 ELSE 0 END) AS bai, 
                                                      MAX(CASE WHEN libelle LIKE 'NIF%' THEN 1 ELSE 0 END) AS bnif, MAX(CASE WHEN libelle LIKE 'PIN%' THEN 1 ELSE 0 END) AS bpin, 
                                                      MAX(CASE WHEN libelle LIKE 'AN%' THEN 1 ELSE 0 END) AS ban, MAX(CASE WHEN libelle LIKE 'FC%' THEN 1 ELSE 0 END) AS bfc
                              FROM           dbo.DocTiers
                              GROUP BY CleTiers) AS Doc ON dbo.Tiers.CleTiers = Doc.CleTiers
GO
/****** Object:  View [dbo].[JTIERS2]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JTIERS2]
AS
SELECT     dbo.Tiers.CleTiers, dbo.TypeTiers.CleTypeTiers, dbo.Tiers.CodeTiers, dbo.SousCompte.NbCompte, dbo.Tiers.RefTiers, dbo.Tiers.RaisonSociale, dbo.Tiers.Tel, 
                      dbo.Tiers.Fax, dbo.Tiers.Mobile, dbo.Tiers.EMail, dbo.Tiers.Correspondant, dbo.Tiers.Adresse, dbo.Tiers.Ville, dbo.Wilaya.Wilaya, dbo.Region.Region, 
                      dbo.Tiers.Echeances, dbo.FamilleTiers.FamilleTiers, dbo.CategorieTiers.CategorieTiers, dbo.Tiers.Remarque, dbo.Tiers.bLocked, dbo.Tiers.Solde, dbo.Tiers.ExoTVA, 
                      dbo.Tiers.CleTypeTiers AS Expr1, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, dbo.Tiers.CleCategorieTiers, dbo.Tiers.CleCompte
FROM         dbo.Tiers INNER JOIN
                      dbo.TypeTiers ON dbo.Tiers.CleTypeTiers = dbo.TypeTiers.CleTypeTiers LEFT OUTER JOIN
                      dbo.SousCompte ON dbo.Tiers.CleCompte = dbo.SousCompte.CleSousCompte LEFT OUTER JOIN
                      dbo.FamilleTiers ON dbo.Tiers.CleFamilleTiers = dbo.FamilleTiers.CleFamilleTiers LEFT OUTER JOIN
                      dbo.CategorieTiers ON dbo.Tiers.CleCategorieTiers = dbo.CategorieTiers.CleCategorieTiers LEFT OUTER JOIN
                      dbo.Region ON dbo.Tiers.CleRegion = dbo.Region.CleRegion LEFT OUTER JOIN
                      dbo.Wilaya ON dbo.Tiers.CleWilaya = dbo.Wilaya.CleWilaya






GO
/****** Object:  View [dbo].[JTRANSACT]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JTRANSACT]
AS
SELECT      dbo.Transact.Date, dbo.Compte.Compte, dbo.Transact.Libelle, dbo.Tiers.RaisonSociale, dbo.Transact.Ref, dbo.Mode.Mode, dbo.Transact.Debit, dbo.Transact.Credit, 
                        dbo.EtatTransaction.EtatTransaction, dbo.Transact.DateEcheance, dbo.Transact.DateValeur, dbo.CategorieTransaction.CategorieTransaction, dbo.Tiers.CodeCompta, dbo.Tiers.CodeTiers, 
                        demarcheur.Name AS Vendeur, dbo.[User].Name, dbo.Transact.bLocked, dbo.Transact.CleTransact, dbo.FamilleTiers.FamilleTiers, dbo.Region.Region, dbo.Wilaya.Wilaya, 
                        dbo.CategorieTiers.CategorieTiers, dbo.Tiers.CleTypeTiers, dbo.Transact.bTransact, dbo.Compte.CleCompte, dbo.Transact.CleMode, dbo.Transact.CleCompte AS Expr1, dbo.Transact.CleTiers, 
                        dbo.Transact.CleCategorieTransaction, dbo.Transact.CleEtatTransact, dbo.Transact.CleUser, dbo.Transact.CleVendeur, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, 
                        dbo.Tiers.CleCategorieTiers, dbo.Transact.CleEffet, dbo.CategorieTransaction.Couleur, dbo.EtatTransaction.Couleur AS CouleurEtat, dbo.Transact.bExplorer, Dtrans.Mont, dbo.Transact.Invisible, 
                        dbo.Transact.RemisePourcent, dbo.Transact.RemisePourcent2, CASE WHEN Doc.CleTransaction IS NULL THEN 0 ELSE 1 END AS bDoc, CASE WHEN Compta.CleJour IS NULL THEN 0 ELSE 1 END AS bCompta, 
                        dbo.Transact.DateRemise, dbo.EtatTransaction.bOK, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, dbo.Tiers.CleUser AS CleUserAss, dbo.Tiers.CleUserActuel
FROM          dbo.Compte RIGHT OUTER JOIN
                        dbo.Transact LEFT OUTER JOIN
                            (SELECT      CleTransaction
                              FROM           dbo.DocTransaction
                              GROUP BY CleTransaction) AS Doc ON dbo.Transact.CleTransact = Doc.CleTransaction LEFT OUTER JOIN
                            (SELECT      CleJour
                              FROM           dbo.Ecriture
                              WHERE       (Jour = 4)
                              GROUP BY CleJour) AS Compta ON dbo.Transact.CleTransact = Compta.CleJour LEFT OUTER JOIN
                            (SELECT      CleTransaction, CASE WHEN Mon < 0 THEN - CONVERT(DECIMAL(18, 2), Mon) ELSE CONVERT(DECIMAL(18, 2), Mon) END AS Mont
                              FROM           (SELECT      dbo.DetailTrans.CleTransaction, SUM(CASE WHEN CleTypeEffet IN (7, 8, 11, 12) THEN - dbo.DetailTrans.Tranche WHEN CleTypeEffet IN (5, 6, 9, 10) 
                                                                               THEN dbo.DetailTrans.Tranche WHEN (CleTypeEffetCharge = 2 AND CleTypeTiers IN (1, 3)) OR
                                                                               (CleTypeEffetCharge = 1 AND CleTypeTiers = 2) THEN - dbo.DetailTrans.Tranche WHEN (CleTypeEffetCharge = 1 AND CleTypeTiers IN (1, 3)) OR
                                                                               (CleTypeEffetCharge = 2 AND CleTypeTiers = 2) THEN dbo.DetailTrans.Tranche END) AS Mon
                                                       FROM           dbo.EffetCharge RIGHT OUTER JOIN
                                                                               dbo.Transact AS tr INNER JOIN
                                                                               dbo.Tiers AS tir ON tr.CleTiers = tir.CleTiers RIGHT OUTER JOIN
                                                                               dbo.DetailTrans ON tr.CleTransact = dbo.DetailTrans.CleTransaction LEFT OUTER JOIN
                                                                               dbo.Effet ON dbo.DetailTrans.CleEffet = dbo.Effet.CleEffet ON dbo.EffetCharge.CleEffetCharge = dbo.DetailTrans.CleEffetCharge
                                                       GROUP BY dbo.DetailTrans.CleTransaction) AS Trs) AS Dtrans ON dbo.Transact.CleTransact = Dtrans.CleTransaction LEFT OUTER JOIN
                        dbo.[User] AS demarcheur ON dbo.Transact.CleVendeur = demarcheur.CleUser ON dbo.Compte.CleCompte = dbo.Transact.CleCompte LEFT OUTER JOIN
                        dbo.CategorieTransaction ON dbo.Transact.CleCategorieTransaction = dbo.CategorieTransaction.CleCategorieTransaction LEFT OUTER JOIN
                        dbo.CategorieTiers RIGHT OUTER JOIN
                        dbo.Tiers ON dbo.CategorieTiers.CleCategorieTiers = dbo.Tiers.CleCategorieTiers LEFT OUTER JOIN
                        dbo.Wilaya ON dbo.Tiers.CleWilaya = dbo.Wilaya.CleWilaya LEFT OUTER JOIN
                        dbo.Region ON dbo.Tiers.CleRegion = dbo.Region.CleRegion LEFT OUTER JOIN
                        dbo.FamilleTiers ON dbo.Tiers.CleFamilleTiers = dbo.FamilleTiers.CleFamilleTiers ON dbo.Transact.CleTiers = dbo.Tiers.CleTiers LEFT OUTER JOIN
                        dbo.[User] ON dbo.Transact.CleUser = dbo.[User].CleUser LEFT OUTER JOIN
                        dbo.Mode ON dbo.Transact.CleMode = dbo.Mode.CleMode LEFT OUTER JOIN
                        dbo.EtatTransaction ON dbo.Transact.CleEtatTransact = dbo.EtatTransaction.CleEtatTransact
GO
/****** Object:  View [dbo].[JTRANSFERT]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JTRANSFERT]
AS
SELECT      TOP (100) PERCENT dbo.Effet.CleEffet, dbo.Effet.CleTypeEffet, dbo.Effet.Reference, dbo.Effet.Date, dbo.Effet.Date2, dbo.Tiers.CodeTiers, dbo.Tiers.RaisonSociale, dbo.Effet.MontantHT, 
                        dbo.Effet.MonantTTC, dbo.Mode.Mode, dbo.Effet.Payement, dbo.Effet.MonantTTC - dbo.Effet.Payement AS Reste, dbo.Effet.Timbre, dbo.Effet.TotalTVA, dbo.Effet.TotalSHP, dbo.Effet.TotalPPA, 
                        dbo.Effet.Remise, dbo.Effet.RemisePourcent, dbo.Effet.MontantHT + dbo.Effet.Remise AS NetHT, dbo.CategorieEffet.CategorieEffet, User_2.Name, dbo.Depot.Depot, Depot_1.Depot AS Depot2, 
                        dbo.EtatEffet.EtatEffet, dbo.CategorieTiers.CategorieTiers, dbo.Vehicule.Vehicule, dbo.TypeTiers.TypeTiers, dbo.FamilleTiers.FamilleTiers, dbo.Region.Region, dbo.Wilaya.Wilaya, 
                        dbo.Effet.Associe, dbo.Effet.Cloture, dbo.Effet.CleEntreprise, dbo.Effet.CleTiers, dbo.Effet.CleCategorieEffet, dbo.Effet.CleUser, dbo.Effet.CleCommercial, dbo.Effet.CleMode, dbo.Effet.CleDepot, 
                        dbo.Effet.CleDepot2, dbo.Effet.CleVehicule, dbo.Effet.CleVendeur, dbo.Effet.CleEtatEffet, dbo.Tiers.CleTypeTiers, dbo.Tiers.CleFamilleTiers, dbo.Tiers.CleWilaya, dbo.Tiers.CleRegion, 
                        dbo.Tiers.CleCategorieTiers, dbo.CategorieEffet.Couleur, dbo.EtatEffet.Couleur AS CouleurEtat, dbo.Tiers.CleUser AS CleUserAss, dbo.Effet.Invisible, dbo.Effet.MontantBrute, 
                        dbo.Effet.RemisePourcent2, dbo.Effet.Remise2, dbo.[User].Name AS Commercial, User_1.Name AS Vendeur, CASE WHEN Doc.CleEffet IS NULL THEN 0 ELSE 1 END AS bDoc, dbo.Effet.bPsycho, 
                        dbo.Effet.bControle, dbo.Tiers.CleStatutTiers, dbo.Tiers.CleSolvabilite, dbo.Tiers.CleUserActuel
FROM          dbo.Mode RIGHT OUTER JOIN
                        dbo.Effet INNER JOIN
                        dbo.Depot AS Depot_1 ON dbo.Effet.CleDepot2 = Depot_1.CleDepot LEFT OUTER JOIN
                        dbo.[User] ON dbo.Effet.CleCommercial = dbo.[User].CleUser LEFT OUTER JOIN
                        dbo.[User] AS User_1 ON dbo.Effet.CleVendeur = User_1.CleUser LEFT OUTER JOIN
                        dbo.Vehicule ON dbo.Effet.CleVehicule = dbo.Vehicule.CleVehicule LEFT OUTER JOIN
                        dbo.EtatEffet ON dbo.Effet.CleEtatEffet = dbo.EtatEffet.CleEtatEffet LEFT OUTER JOIN
                        dbo.Depot ON dbo.Effet.CleDepot = dbo.Depot.CleDepot LEFT OUTER JOIN
                        dbo.CategorieEffet ON dbo.Effet.CleCategorieEffet = dbo.CategorieEffet.CleCategorieEffet ON dbo.Mode.CleMode = dbo.Effet.CleMode LEFT OUTER JOIN
                        dbo.[User] AS User_2 ON dbo.Effet.CleUser = User_2.CleUser LEFT OUTER JOIN
                        dbo.TypeTiers RIGHT OUTER JOIN
                        dbo.Region RIGHT OUTER JOIN
                        dbo.Tiers LEFT OUTER JOIN
                        dbo.FamilleTiers ON dbo.Tiers.CleFamilleTiers = dbo.FamilleTiers.CleFamilleTiers LEFT OUTER JOIN
                        dbo.Wilaya ON dbo.Tiers.CleWilaya = dbo.Wilaya.CleWilaya ON dbo.Region.CleRegion = dbo.Tiers.CleRegion ON dbo.TypeTiers.CleTypeTiers = dbo.Tiers.CleTypeTiers LEFT OUTER JOIN
                        dbo.CategorieTiers ON dbo.Tiers.CleCategorieTiers = dbo.CategorieTiers.CleCategorieTiers ON dbo.Effet.CleTiers = dbo.Tiers.CleTiers LEFT OUTER JOIN
                            (SELECT      CleEffet
                              FROM           dbo.DocEffet
                              GROUP BY CleEffet) AS Doc ON dbo.Effet.CleEffet = Doc.CleEffet
WHERE      (dbo.Effet.CleTypeEffet = 19)
ORDER BY dbo.Effet.CleEffet
GO
/****** Object:  View [dbo].[JVENTECPT]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JVENTECPT]
AS
SELECT      TOP (100) PERCENT dbo.OpComptoir.CleOpComptoir, dbo.OpComptoir.CleTrace, dbo.OpComptoir.CleTypeOperation, dbo.OpComptoir.CleCaisseComptoir, dbo.OpComptoir.Reference, 
                        dbo.OpComptoir.Libelle, dbo.OpComptoir.CleTiers, dbo.OpComptoir.CleFidelisation, dbo.OpComptoir.CleUser, dbo.OpComptoir.CleCompte, dbo.OpComptoir.Heure, dbo.OpComptoir.MontantHT, 
                        dbo.OpComptoir.Remise, dbo.OpComptoir.MontantTVA, dbo.OpComptoir.Timbre, dbo.OpComptoir.MontantTTC, dbo.OpComptoir.Payement, 
                        dbo.OpComptoir.MontantTTC - dbo.OpComptoir.Payement AS reste, dbo.OpComptoir.Avance, dbo.OpComptoir.RefBLF, dbo.OpComptoir.RefRecu, dbo.OpComptoir.bEspece, 
                        dbo.OpComptoir.bInstance, dbo.OpComptoir.CleSessionComptoir, dbo.OpComptoir.CleEtatOpComptoir, dbo.OpComptoir.CleGroupeComptoir, dbo.OpComptoir.CleDepot, 
                        dbo.OpComptoir.TotalRemise, dbo.TypeOpComptoir.TypeOperation, dbo.CaisseComptoir.CaisseComptoir, dbo.CaisseComptoir.Montant, dbo.[User].Name, dbo.Tiers.CodeTiers, 
                        dbo.Tiers.RaisonSociale, dbo.Depot.Depot, dbo.GroupeComptoir.GroupeComptoir, dbo.Tiers.bPoint, dbo.Tiers.Point, dbo.EtatOpComptoir.EtatOpComptoir AS Etat, dbo.EtatOpComptoir.Couleur, 
                        CAST(FORMAT(dbo.OpComptoir.Heure, 'dd-MM-yyyy') AS datetime) AS Dat
FROM          dbo.OpComptoir LEFT OUTER JOIN
                        dbo.EtatOpComptoir ON dbo.OpComptoir.CleEtatOpComptoir = dbo.EtatOpComptoir.CleEtatOpComptoir LEFT OUTER JOIN
                        dbo.GroupeComptoir ON dbo.OpComptoir.CleGroupeComptoir = dbo.GroupeComptoir.CleGroupeComptoir LEFT OUTER JOIN
                        dbo.TypeOpComptoir ON dbo.OpComptoir.CleTypeOperation = dbo.TypeOpComptoir.CleTypeOperation LEFT OUTER JOIN
                        dbo.Depot ON dbo.OpComptoir.CleDepot = dbo.Depot.CleDepot LEFT OUTER JOIN
                        dbo.CaisseComptoir ON dbo.OpComptoir.CleCaisseComptoir = dbo.CaisseComptoir.CleCaisseComptoir LEFT OUTER JOIN
                        dbo.Tiers ON dbo.OpComptoir.CleTiers = dbo.Tiers.CleTiers LEFT OUTER JOIN
                        dbo.[User] ON dbo.OpComptoir.CleUser = dbo.[User].CleUser
ORDER BY dbo.OpComptoir.CleOpComptoir DESC




GO
/****** Object:  View [dbo].[Lot_mvt]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Lot_mvt]
AS
SELECT        dbo.Lot.CleLot, dbo.Lot.CleProduit
FROM            dbo.Lot INNER JOIN
                         dbo.DetailEffet ON dbo.Lot.CleLot = dbo.DetailEffet.CleLot INNER JOIN
                         dbo.Effet ON dbo.DetailEffet.CleEffet = dbo.Effet.CleEffet
WHERE        (dbo.Effet.CleTypeEffet IN (9, 10, 11, 12, 13, 14, 15, 16))
GROUP BY dbo.Lot.CleLot, dbo.Lot.CleProduit




GO
/****** Object:  View [dbo].[lotdouble]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[lotdouble]
AS
SELECT      dbo.Effet.Reference, dbo.Effet.Date, dbo.Effet.RemisePourcent, dbo.Effet.Remise, dbo.DetailEffet.Designation, dbo.Lot.NLot, dbo.Lot.DateExp, dbo.Lot.PPA, dbo.Lot.SHP, 
                        dbo.Lot.Remise AS Expr1
FROM          dbo.Effet INNER JOIN
                        dbo.DetailEffet ON dbo.Effet.CleEffet = dbo.DetailEffet.CleEffet INNER JOIN
                        dbo.Lot ON dbo.DetailEffet.CleLot = dbo.Lot.CleLot
WHERE      (dbo.Effet.CleTypeEffet IN (9, 11)) AND (CAST(dbo.Effet.RemisePourcent AS INT) <> 0)




GO
/****** Object:  View [dbo].[PeriodeOperation]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PeriodeOperation]
AS
SELECT      CONVERT(varchar(7), Periode, 126) AS mois
FROM          dbo.UpOperation
GROUP BY CONVERT(varchar(7), Periode, 126)
GO
/****** Object:  View [dbo].[PeriodePaye]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PeriodePaye]
AS
SELECT      CONVERT(varchar(7), Periode, 126) AS mois
FROM          dbo.UpPaye
GROUP BY CONVERT(varchar(7), Periode, 126)



GO
/****** Object:  View [dbo].[PeriodePoint]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PeriodePoint]
AS
SELECT      CONVERT(varchar(7), Date, 126) AS mois
FROM          dbo.UpPoint
GROUP BY CONVERT(varchar(7), Date, 126)
GO
/****** Object:  View [dbo].[ProduitLot]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProduitLot]
AS
SELECT      dbo.Lot.CleLot, dbo.Lot.CleProduit, dbo.Produit.Code, dbo.Produit.Reference, dbo.Produit.Designation, dbo.Lot.NLot, dbo.Lot.DateExp, dbo.Lot.Quantite, dbo.Lot.PPA, dbo.Lot.PrixAchat, dbo.Produit.bBloque, 
                        dbo.Lot.bBloque AS bBloque2, dbo.Taxe.Valeur, dbo.Lot.MargePh, dbo.Lot.SHP, dbo.Produit.RistPromo, dbo.Produit.DebutPromo, dbo.Produit.FinPromo, dbo.Produit.TR, dbo.Produit.bPsycho, 
                        dbo.Produit.Invisible, dbo.Lot.Invisible AS Invisible2, dbo.Produit.HorsStock, dbo.Produit.QF, dbo.Produit.CleDefaultColisage, dbo.Produit.bPerimable, dbo.Produit.bCompose, dbo.Lot.CodeLot
FROM          dbo.Produit INNER JOIN
                        dbo.Lot ON dbo.Produit.CleProduit = dbo.Lot.CleProduit LEFT OUTER JOIN
                        dbo.Taxe ON dbo.Produit.CleTVA = dbo.Taxe.CleTaxe




GO
/****** Object:  View [dbo].[ProfileStruct]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProfileStruct]
AS
SELECT      CleUser, Name, Password, Info, Bloque, Profile, CleProfile, CleTiers
FROM          dbo.[User]
WHERE      (Profile = 2) AND (Bloque = 0)




GO
/****** Object:  View [dbo].[RegEffet]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RegEffet]
AS
SELECT      CleEffet, STUFF(
         (SELECT DISTINCT ',' + Ref
          FROM ( SELECT      dbo.DetailTrans.CleEffet, dbo.Transact.Ref
                        FROM           dbo.DetailTrans INNER JOIN
                                                dbo.Transact ON dbo.DetailTrans.CleTransaction = dbo.Transact.CleTransact
                        ) as r
          WHERE r.[CleEffet] = Ref.[CleEffet]  FOR XML PATH (''))
          , 1, 1, '')  AS Reference
FROM          (SELECT      dbo.DetailTrans.CleEffet, dbo.Transact.Ref
                        FROM           dbo.DetailTrans INNER JOIN
                                                dbo.Transact ON dbo.DetailTrans.CleTransaction = dbo.Transact.CleTransact
                        GROUP BY dbo.DetailTrans.CleEffet, dbo.Transact.Ref) AS Ref
GROUP BY CleEffet




GO
/****** Object:  View [dbo].[rp_Lot]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[rp_Lot]
AS
SELECT      MIN(CleLot) AS CleL, CleProduit AS CleP, MIN(DateExp) AS Datexp, MIN(PPA) AS PPAm, MIN(MargePh) AS Margem, MIN(MaxUG2) AS UGm, MAX(Quantite) AS Qt, MAX(1) AS CleEntreprise
FROM          (SELECT      DateExp, CleLot, PPA, MargePh, MaxUG2, CleProduit, Quantite - QteGarde AS Quantite
                        FROM           dbo.Lot
                        WHERE       (DateExp > SYSDATETIME()) AND (PPA > 1) AND (Quantite - QteGarde > 0)) AS LO
GROUP BY CleProduit

GO
/****** Object:  View [dbo].[rptBalance]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[rptBalance]
AS
SELECT      dbo.[Plan].NbCompte, dbo.[Plan].Libelle, Ouverture.SommeDebit, Ouverture.SommeCredit, Cour.SommeDebit2, Cour.SommeCredit2, Cour.exo, Ouverture.exo AS ExoOuverture
FROM          dbo.[Plan] LEFT OUTER JOIN
                            (SELECT      YEAR(dbo.Ecriture.Date) AS exo, dbo.DetailEcriture.Compte, SUM(dbo.DetailEcriture.Debit) AS SommeDebit2, SUM(dbo.DetailEcriture.Credit) AS SommeCredit2, 
                                                      SUM(dbo.DetailEcriture.Debit) - SUM(dbo.DetailEcriture.Credit) AS SommeSolde2
                              FROM           dbo.DetailEcriture INNER JOIN
                                                      dbo.Ecriture ON dbo.DetailEcriture.CleEcriture = dbo.Ecriture.CleEcriture
                              WHERE       (dbo.Ecriture.CleJournal <> 1)
                              GROUP BY dbo.DetailEcriture.Compte, YEAR(dbo.Ecriture.Date)) AS Cour ON dbo.[Plan].NbCompte = Cour.Compte LEFT OUTER JOIN
                            (SELECT      YEAR(Ecriture_1.Date) AS exo, DetailEcriture_1.Compte, SUM(DetailEcriture_1.Debit) AS SommeDebit, SUM(DetailEcriture_1.Credit) AS SommeCredit, SUM(DetailEcriture_1.Debit) 
                                                      - SUM(DetailEcriture_1.Credit) AS SommeSolde
                              FROM           dbo.DetailEcriture AS DetailEcriture_1 INNER JOIN
                                                      dbo.Ecriture AS Ecriture_1 ON DetailEcriture_1.CleEcriture = Ecriture_1.CleEcriture
                              WHERE       (Ecriture_1.CleJournal = 1)
                              GROUP BY DetailEcriture_1.Compte, YEAR(Ecriture_1.Date)) AS Ouverture ON dbo.[Plan].NbCompte = Ouverture.Compte
WHERE      (Ouverture.SommeDebit IS NOT NULL) OR
                        (Ouverture.SommeCredit IS NOT NULL) OR
                        (Cour.SommeDebit2 IS NOT NULL) OR
                        (Cour.SommeCredit2 IS NOT NULL)




GO
/****** Object:  View [dbo].[rptDetailInventaire]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[rptDetailInventaire]
AS
SELECT      dbo.Emplacement.Emplacement, dbo.Lot.CleEmplacement, dbo.DetailInventaire.CleInventaire, dbo.Produit.Code, dbo.Produit.Designation, dbo.Lot.NLot, dbo.Lot.DateExp, 
                        dbo.DetailInventaire.Quantite, dbo.Lot.Quantite AS Expr1, dbo.Produit.PMP, dbo.Produit.bPerimable, dbo.Produit.CleFamilleArticle, dbo.DetailInventaire.bEdited, dbo.DetailInventaire.QteStock, 
                        dbo.Produit.CleMarque, dbo.Lot.CleLot, dbo.Produit.CleProduit, dbo.DetailInventaire.CleDetailInventaire, dbo.Lot.PPA, dbo.Marque.Marque, dbo.DetailInventaire.Comptage, 
                        dbo.DetailInventaire.CleUser
FROM          dbo.Produit INNER JOIN
                        dbo.Emplacement RIGHT OUTER JOIN
                        dbo.Lot ON dbo.Emplacement.CleEmplacement = dbo.Lot.CleEmplacement INNER JOIN
                        dbo.DetailInventaire ON dbo.Lot.CleLot = dbo.DetailInventaire.CleLot ON dbo.Produit.CleProduit = dbo.Lot.CleProduit LEFT OUTER JOIN
                        dbo.Marque ON dbo.Lot.CleMarque = dbo.Marque.CleMarque




GO
/****** Object:  View [dbo].[StockEntreeSortie]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StockEntreeSortie]
AS
SELECT     TOP (100) PERCENT dbo.DetailEffet.CleLot, dbo.Effet.Date, dbo.Effet.Reference, CASE WHEN CleTypeEffet IN (13, 9, 16) 
                      THEN dbo.DetailEffet.Quantite ELSE 0 END AS entree, CASE WHEN CleTypeEffet IN (11, 14) THEN - dbo.DetailEffet.Quantite ELSE 0 END AS sortie, 
                      dbo.DetailEffet.PrixUnitaireTTC, dbo.Effet.CleTypeEffet, dbo.Effet.CleDepot
FROM         dbo.Effet INNER JOIN
                      dbo.DetailEffet ON dbo.Effet.CleEffet = dbo.DetailEffet.CleEffet
WHERE     (dbo.Effet.CleTypeEffet IN (9, 11, 13, 14, 16))
ORDER BY dbo.Effet.Date




GO
/****** Object:  View [dbo].[StockInit]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StockInit]
AS
SELECT     CleLot, CASE WHEN Init.Quantite IS NULL THEN 0 ELSE Init.Quantite END AS Qtt
FROM         (SELECT     dbo.Lot.CleLot, Lot_init.Quantite
                       FROM          (SELECT     dbo.DetailEffet.CleLot, dbo.DetailEffet.Quantite
                                               FROM          dbo.Effet INNER JOIN
                                                                      dbo.DetailEffet ON dbo.Effet.CleEffet = dbo.DetailEffet.CleEffet
                                               WHERE      (dbo.Effet.CleTypeEffet = 13) AND (dbo.DetailEffet.Offset = 1)) AS Lot_init RIGHT OUTER JOIN
                                              dbo.Lot ON Lot_init.CleLot = dbo.Lot.CleLot) AS Init




GO
/****** Object:  View [dbo].[TrancheEffet]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TrancheEffet]
AS
SELECT      CleEffet, STRING_AGG(CAST('(  ' + Mode + ' ' + Ref + ' : ' + format(Tranche, '### ### ### ##0.00') + ' ) ' AS nvarchar(MAX)), ',') AS pay
FROM          (SELECT      dbo.DetailTrans.CleEffet, dbo.Transact.Ref, dbo.DetailTrans.Tranche, dbo.Mode.Mode
                        FROM           dbo.DetailTrans INNER JOIN
                                                dbo.Transact ON dbo.DetailTrans.CleTransaction = dbo.Transact.CleTransact LEFT OUTER JOIN
                                                dbo.Mode ON dbo.Transact.CleMode = dbo.Mode.CleMode
                        WHERE       (dbo.DetailTrans.CleEffet > 0)
                        GROUP BY dbo.DetailTrans.CleEffet, dbo.Transact.Ref, dbo.DetailTrans.Tranche, dbo.Mode.Mode) AS t
GROUP BY CleEffet
GO
/****** Object:  View [dbo].[TrancheEffetCharge]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TrancheEffetCharge]
AS
SELECT      CleEffetCharge, STRING_AGG(CAST('(  ' + Mode + ' ' + Ref + ' : ' + format(Tranche, '### ### ### ##0.00') + ' ) ' AS nvarchar(MAX)), ',') AS pay
FROM          (SELECT      dbo.DetailTrans.CleEffetCharge, dbo.Transact.Ref, dbo.DetailTrans.Tranche, dbo.Mode.Mode
                        FROM           dbo.DetailTrans INNER JOIN
                                                dbo.Transact ON dbo.DetailTrans.CleTransaction = dbo.Transact.CleTransact LEFT OUTER JOIN
                                                dbo.Mode ON dbo.Transact.CleMode = dbo.Mode.CleMode
                        WHERE       (dbo.DetailTrans.CleEffetCharge > 0)
                        GROUP BY dbo.DetailTrans.CleEffetCharge, dbo.Transact.Ref, dbo.DetailTrans.Tranche, dbo.Mode.Mode) AS t
GROUP BY CleEffetCharge
GO
/****** Object:  View [dbo].[TypeEffetAll]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TypeEffetAll]
AS
SELECT      CleTypeEffet, TypeEffet
FROM          dbo.TypeEffet
WHERE      (CleTypeEffet IN (5, 6, 7, 8))
UNION ALL
SELECT      CleTypeEffetCharge, TypeEffetCharge
FROM          dbo.TypeEffetCharge
GO
/****** Object:  View [dbo].[UserInfoEmp]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UserInfoEmp]
AS
SELECT      dbo.[User].CleUser, dbo.[User].Name, dbo.[User].Profile, dbo.UserInfo.Code, dbo.UserInfo.NomComplet, dbo.UserInfo.SalaireBase, dbo.UserInfo.DateRecrutement, dbo.UserInfo.Compte, 
                        dbo.UserInfo.DateDepart
FROM          dbo.[User] INNER JOIN
                        dbo.UserInfo ON dbo.[User].CleUser = dbo.UserInfo.CleUser




GO
/****** Object:  View [dbo].[UserPme]    Script Date: 04/09/2023 10:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UserPme]
AS
SELECT      dbo.[User].CleUser, dbo.[User].Name, dbo.UserInfo.Photo
FROM          dbo.[User] INNER JOIN
                        dbo.UserInfo ON dbo.[User].CleUser = dbo.UserInfo.CleUser
WHERE      (dbo.UserInfo.ClePosition = 1)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DetailEcriture"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Plan"
            Begin Extent = 
               Top = 27
               Left = 304
               Bottom = 144
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'__CptBalance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'__CptBalance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DetailEcriture"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 254
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Ecriture"
            Begin Extent = 
               Top = 6
               Left = 292
               Bottom = 125
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2835
         Alias = 2010
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'__ExerciceBalance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'__ExerciceBalance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DetailEcriture"
            Begin Extent = 
               Top = 24
               Left = 37
               Bottom = 143
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Ecriture"
            Begin Extent = 
               Top = 6
               Left = 275
               Bottom = 125
               Right = 475
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'__OuvertureBalance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'__OuvertureBalance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DetailEcriture"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "SousCompte"
            Begin Extent = 
               Top = 6
               Left = 276
               Bottom = 125
               Right = 476
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'__SCptBalance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'__SCptBalance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DetailEcriture"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 123
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'__SCptBalance2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'__SCptBalance2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1860
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_tiers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_tiers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "balances"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BALANCE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BALANCE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "balancestiers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BALANCETIERS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BALANCETIERS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Lot"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 254
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'bsQteProduit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'bsQteProduit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Effet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 18
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'bsReglement'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'bsReglement'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EffetAll"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'bsReglementAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'bsReglementAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 84
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DetailEffet"
            Begin Extent = 
               Top = 7
               Left = 155
               Bottom = 126
               Right = 355
            End
            DisplayFlags = 280
            TopColumn = 33
         End
         Begin Table = "Lot"
            Begin Extent = 
               Top = 6
               Left = 514
               Bottom = 125
               Right = 714
            End
            DisplayFlags = 280
            TopColumn = 21
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DetailEffetLot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DetailEffetLot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Lot"
            Begin Extent = 
               Top = 6
               Left = 276
               Bottom = 125
               Right = 476
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DetailOpComptoir"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "Produit"
            Begin Extent = 
               Top = 9
               Left = 559
               Bottom = 128
               Right = 759
            End
            DisplayFlags = 280
            TopColumn = 65
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DetailOpComptoirLot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DetailOpComptoirLot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[16] 2[30] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 48
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EffetAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EffetAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "derivedtbl_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 93
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Effet_1"
            Begin Extent = 
               Top = 5
               Left = 309
               Bottom = 122
               Right = 513
            End
            DisplayFlags = 280
            TopColumn = 18
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 6
               Left = 551
               Bottom = 123
               Right = 755
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EtatDoubleEmploi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EtatDoubleEmploi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 84
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Fournisseur'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Fournisseur'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalEffet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 76
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JACHAT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JACHAT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalEffetAll"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 70
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 63
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 15' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JACHATAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'00
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JACHATAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JACHATAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[17] 2[35] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JCAGNOTEX"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 65
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 62
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCAGNOTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'       Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCAGNOTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCAGNOTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JCAGNOTEX2"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 65
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCAGNOTE2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCAGNOTE2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalCagnote"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 62
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCAGNOTEX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCAGNOTEX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[8] 2[35] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalCagnote"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 62
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 63
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCAGNOTEX2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCAGNOTEX2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCAGNOTEX2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[49] 4[12] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -178
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Region"
            Begin Extent = 
               Top = 424
               Left = 280
               Bottom = 526
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Mode"
            Begin Extent = 
               Top = 304
               Left = 522
               Bottom = 421
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 304
               Left = 38
               Bottom = 421
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 84
         End
         Begin Table = "EtatEffet"
            Begin Extent = 
               Top = 295
               Left = 764
               Bottom = 412
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EffetCharge"
            Begin Extent = 
               Top = 304
               Left = 280
               Bottom = 421
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieCharge"
            Begin Extent = 
               Top = 526
               Left = 522
               Bottom = 643
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 184
               Left = 38
               Bottom = 301
               Right = 242
            End
            Displ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCHARGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'ayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FamilleTiers"
            Begin Extent = 
               Top = 184
               Left = 280
               Bottom = 301
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Wilaya"
            Begin Extent = 
               Top = 424
               Left = 38
               Bottom = 526
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeTiers"
            Begin Extent = 
               Top = 424
               Left = 522
               Bottom = 526
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieTiers"
            Begin Extent = 
               Top = 184
               Left = 38
               Bottom = 301
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doc"
            Begin Extent = 
               Top = 526
               Left = 38
               Bottom = 598
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Compta"
            Begin Extent = 
               Top = 526
               Left = 280
               Bottom = 598
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCHARGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCHARGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalEffet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 76
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCMDCL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCMDCL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalEffet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 76
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCMDFR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCMDFR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[27] 2[8] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Compte"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Entreprise"
            Begin Extent = 
               Top = 6
               Left = 276
               Bottom = 125
               Right = 476
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3540
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCOMPTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCOMPTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[39] 4[7] 2[25] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -60
      End
      Begin Tables = 
         Begin Table = "Real"
            Begin Extent = 
               Top = 6
               Left = 98
               Bottom = 108
               Right = 302
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "palier"
            Begin Extent = 
               Top = 6
               Left = 340
               Bottom = 123
               Right = 544
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Convention"
            Begin Extent = 
               Top = 6
               Left = 582
               Bottom = 123
               Right = 786
            End
            DisplayFlags = 280
            TopColumn = 24
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 108
               Left = 98
               Bottom = 225
               Right = 302
            End
            DisplayFlags = 280
            TopColumn = 43
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 228
               Left = 98
               Bottom = 345
               Right = 302
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 29
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 150' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JConvention'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'0
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JConvention'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JConvention'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Real"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 108
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "palier"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Convention"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 123
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 108
               Left = 38
               Bottom = 225
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 43
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 228
               Left = 38
               Bottom = 345
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 29
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 150' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JConvention2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'0
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JConvention2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JConvention2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Plan"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieCompte"
            Begin Extent = 
               Top = 100
               Left = 309
               Bottom = 219
               Right = 509
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StatutCompte"
            Begin Extent = 
               Top = 57
               Left = 702
               Bottom = 176
               Right = 902
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NatureCompte"
            Begin Extent = 
               Top = 0
               Left = 601
               Bottom = 119
               Right = 801
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCPT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCPT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCPT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalEffet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 76
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCTRCL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCTRCL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalEffet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 76
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCTRFR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JCTRFR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[52] 4[9] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ecriture"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_1"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 123
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Journal"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 243
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Classeur"
            Begin Extent = 
               Top = 126
               Left = 280
               Bottom = 228
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doc"
            Begin Extent = 
               Top = 126
               Left = 522
               Bottom = 213
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 16
         Width = 284
         Width = 1500
         Width = 1500
         Widt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JECRITURE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'h = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JECRITURE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JECRITURE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[7] 2[29] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ecriture"
            Begin Extent = 
               Top = 0
               Left = 308
               Bottom = 119
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DetailEcriture"
            Begin Extent = 
               Top = 0
               Left = 18
               Bottom = 119
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Plan"
            Begin Extent = 
               Top = 294
               Left = 38
               Bottom = 411
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SousCompte"
            Begin Extent = 
               Top = 348
               Left = 261
               Bottom = 467
               Right = 461
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NatureCompte"
            Begin Extent = 
               Top = 120
               Left = 339
               Bottom = 239
               Right = 539
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StatutCompte"
            Begin Extent = 
               Top = 142
               Left = 646
               Bottom = 261
               Right = 846
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieCompte"
            Begin Extent = 
               Top = 280
               Left = 440
               Bottom = 399
               Right = 640
            End
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JECRITURE2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'          DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Journal"
            Begin Extent = 
               Top = 6
               Left = 752
               Bottom = 125
               Right = 952
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Classeur"
            Begin Extent = 
               Top = 41
               Left = 549
               Bottom = 145
               Right = 749
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 28
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JECRITURE2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JECRITURE2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[11] 2[42] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ecriture"
            Begin Extent = 
               Top = 1
               Left = 8
               Bottom = 118
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DetailEcriture"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Plan"
            Begin Extent = 
               Top = 120
               Left = 38
               Bottom = 237
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tier"
            Begin Extent = 
               Top = 150
               Left = 301
               Bottom = 267
               Right = 505
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "NatureCompte"
            Begin Extent = 
               Top = 281
               Left = 563
               Bottom = 398
               Right = 767
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StatutCompte"
            Begin Extent = 
               Top = 276
               Left = 303
               Bottom = 393
               Right = 507
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieCompte"
            Begin Extent = 
               Top = 269
               Left = 33
               Bottom = 386
               Right = 237
            End
            ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JECRITURE3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Journal"
            Begin Extent = 
               Top = 6
               Left = 602
               Bottom = 123
               Right = 806
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Classeur"
            Begin Extent = 
               Top = 134
               Left = 607
               Bottom = 236
               Right = 811
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 30
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JECRITURE3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JECRITURE3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[13] 2[32] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Investissement"
            Begin Extent = 
               Top = 144
               Left = 511
               Bottom = 263
               Right = 712
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Plan_2"
            Begin Extent = 
               Top = 3
               Left = 269
               Bottom = 122
               Right = 469
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Plan_1"
            Begin Extent = 
               Top = 0
               Left = 194
               Bottom = 119
               Right = 394
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Plan"
            Begin Extent = 
               Top = 120
               Left = 38
               Bottom = 237
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AffectationInvestissement"
            Begin Extent = 
               Top = 262
               Left = 214
               Bottom = 381
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeSortie"
            Begin Extent = 
               Top = 179
               Left = 6
               Bottom = 298
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeAmortissement"
            Begin Extent = 
               Top = 57
               Left = 6
               Bottom = 176
               Right = 206
            End
 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JINVEST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'           DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeInvestissement"
            Begin Extent = 
               Top = 30
               Left = 787
               Bottom = 149
               Right = 988
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeAquisition"
            Begin Extent = 
               Top = 156
               Left = 818
               Bottom = 275
               Right = 1018
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Amortissements"
            Begin Extent = 
               Top = 6
               Left = 507
               Bottom = 95
               Right = 707
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 27
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JINVEST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JINVEST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[39] 4[12] 2[34] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Produit"
            Begin Extent = 
               Top = 5
               Left = 299
               Bottom = 124
               Right = 499
            End
            DisplayFlags = 280
            TopColumn = 31
         End
         Begin Table = "Lot"
            Begin Extent = 
               Top = 6
               Left = 586
               Bottom = 147
               Right = 786
            End
            DisplayFlags = 280
            TopColumn = 19
         End
         Begin Table = "Marque"
            Begin Extent = 
               Top = 270
               Left = 595
               Bottom = 374
               Right = 795
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StatutLot"
            Begin Extent = 
               Top = 152
               Left = 601
               Bottom = 271
               Right = 801
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Emplacement"
            Begin Extent = 
               Top = 380
               Left = 600
               Bottom = 499
               Right = 800
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "FamilleArticle"
            Begin Extent = 
               Top = 0
               Left = 34
               Bottom = 119
               Right = 234
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieProduit"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 238
            End
            D' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JLot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'isplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Taxe"
            Begin Extent = 
               Top = 204
               Left = 33
               Bottom = 323
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2955
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JLot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JLot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[49] 4[14] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EtatEffet"
            Begin Extent = 
               Top = 126
               Left = 522
               Bottom = 243
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Effet"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 72
         End
         Begin Table = "Colis"
            Begin Extent = 
               Top = 294
               Left = 38
               Bottom = 411
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_4"
            Begin Extent = 
               Top = 0
               Left = 777
               Bottom = 117
               Right = 981
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_2"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 123
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_3"
            Begin Extent = 
               Top = 582
               Left = 38
               Bottom = 699
               Right = 242
            End
            DisplayFlags = 280
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalEffet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     TopColumn = 0
         End
         Begin Table = "Vehicule"
            Begin Extent = 
               Top = 126
               Left = 280
               Bottom = 243
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Depot"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 363
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieEffet"
            Begin Extent = 
               Top = 246
               Left = 280
               Bottom = 363
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Mode"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_1"
            Begin Extent = 
               Top = 246
               Left = 522
               Bottom = 363
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeTiers"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 468
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Region"
            Begin Extent = 
               Top = 366
               Left = 280
               Bottom = 468
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 366
               Left = 522
               Bottom = 483
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 84
         End
         Begin Table = "FamilleTiers"
            Begin Extent = 
               Top = 468
               Left = 38
               Bottom = 585
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Wilaya"
            Begin Extent = 
               Top = 468
               Left = 280
               Bottom = 570
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieTiers"
            Begin Extent = 
               Top = 486
               Left = 522
               Bottom = 603
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doc"
            Begin Extent = 
               Top = 589
               Left = 507
               Bottom = 661
               Right = 711
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Compta"
            Begin Extent = 
               Top = 582
               Left = 280
               Bottom = 654
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         W' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalEffet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane3', @value=N'idth = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3660
         Alias = 930
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalEffet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=3 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalEffet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[56] 4[5] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Depot"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EffetAll"
            Begin Extent = 
               Top = 16
               Left = 297
               Bottom = 133
               Right = 501
            End
            DisplayFlags = 280
            TopColumn = 47
         End
         Begin Table = "User_2"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 243
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_3"
            Begin Extent = 
               Top = 126
               Left = 280
               Bottom = 243
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Vehicule"
            Begin Extent = 
               Top = 133
               Left = 548
               Bottom = 250
               Right = 752
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "EtatEffet"
            Begin Extent = 
               Top = 126
               Left = 764
               Bottom = 243
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieEffet"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 363
               Right = 242
            End
            DisplayF' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalEffetAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'lags = 280
            TopColumn = 0
         End
         Begin Table = "Mode"
            Begin Extent = 
               Top = 246
               Left = 280
               Bottom = 363
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_1"
            Begin Extent = 
               Top = 246
               Left = 522
               Bottom = 363
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "TypeTiers"
            Begin Extent = 
               Top = 246
               Left = 764
               Bottom = 348
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Region"
            Begin Extent = 
               Top = 348
               Left = 764
               Bottom = 450
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 483
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 84
         End
         Begin Table = "FamilleTiers"
            Begin Extent = 
               Top = 366
               Left = 280
               Bottom = 483
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Wilaya"
            Begin Extent = 
               Top = 366
               Left = 522
               Bottom = 468
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieTiers"
            Begin Extent = 
               Top = 450
               Left = 764
               Bottom = 567
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 73
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Widt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalEffetAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane3', @value=N'h = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalEffetAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=3 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalEffetAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[50] 4[11] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 14
         End
         Begin Table = "UpPaye"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UpDetailPaye"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 123
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "UpFonction"
            Begin Extent = 
               Top = 132
               Left = 57
               Bottom = 249
               Right = 261
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UpRubrique"
            Begin Extent = 
               Top = 165
               Left = 478
               Bottom = 282
               Right = 682
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalPaye'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalPaye'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalPaye'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[18] 2[22] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 1
               Left = 323
               Bottom = 118
               Right = 527
            End
            DisplayFlags = 280
            TopColumn = 30
         End
         Begin Table = "UpFonction"
            Begin Extent = 
               Top = 6
               Left = 565
               Bottom = 123
               Right = 769
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Paie"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 15
         Width = 284
         Width = 1500
         Width = 1620
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalPayeDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalPayeDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Paie"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalPayeDetailGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JournalPayeDetailGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[24] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tbl1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1635
         Width = 1950
         Width = 1950
         Width = 1950
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JPointage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JPointage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[61] 4[5] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Produit"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 37
         End
         Begin Table = "Labo"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FamilleArticle"
            Begin Extent = 
               Top = 78
               Left = 522
               Bottom = 195
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Marque"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 228
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Colissage"
            Begin Extent = 
               Top = 126
               Left = 280
               Bottom = 243
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieProduit"
            Begin Extent = 
               Top = 198
               Left = 522
               Bottom = 315
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Taxe"
            Begin Extent = 
               Top = 228
               Left = 38
               Bottom = 345
               Right = 242
            End
            DisplayFl' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JPRODUIT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'ags = 280
            TopColumn = 0
         End
         Begin Table = "StatutLot"
            Begin Extent = 
               Top = 246
               Left = 280
               Bottom = 363
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Emplacement"
            Begin Extent = 
               Top = 318
               Left = 522
               Bottom = 435
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doc"
            Begin Extent = 
               Top = 348
               Left = 38
               Bottom = 420
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Produit_mvt"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 78
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JPRODUIT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JPRODUIT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalEffet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 76
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JPROFORMAT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JPROFORMAT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CategorieEffet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Effet"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 64
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 294
               Left = 38
               Bottom = 411
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_1"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 243
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Vehicule"
            Begin Extent = 
               Top = 126
               Left = 280
               Bottom = 243
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EtatEffet"
            Begin Extent = 
               Top = 126
               Left = 522
               Bottom = 243
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Depot"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 363
               Right = 242
            End
            DisplayFlags =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JRCC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 280
            TopColumn = 0
         End
         Begin Table = "Mode"
            Begin Extent = 
               Top = 246
               Left = 280
               Bottom = 363
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_2"
            Begin Extent = 
               Top = 246
               Left = 522
               Bottom = 363
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeTiers"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 468
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Region"
            Begin Extent = 
               Top = 366
               Left = 280
               Bottom = 468
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 366
               Left = 522
               Bottom = 483
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 84
         End
         Begin Table = "FamilleTiers"
            Begin Extent = 
               Top = 468
               Left = 38
               Bottom = 585
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Wilaya"
            Begin Extent = 
               Top = 468
               Left = 280
               Bottom = 570
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieTiers"
            Begin Extent = 
               Top = 486
               Left = 522
               Bottom = 603
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doc"
            Begin Extent = 
               Top = 570
               Left = 280
               Bottom = 642
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3315
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JRCC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JRCC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Mode"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Effet"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 64
         End
         Begin Table = "User_1"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 123
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 390
               Left = 38
               Bottom = 507
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Vehicule"
            Begin Extent = 
               Top = 126
               Left = 280
               Bottom = 243
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EtatEffet"
            Begin Extent = 
               Top = 126
               Left = 522
               Bottom = 243
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Depot"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 363
               Right = 242
            End
            DisplayFlags = 280
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JRCF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'       TopColumn = 0
         End
         Begin Table = "CategorieEffet"
            Begin Extent = 
               Top = 246
               Left = 280
               Bottom = 363
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_2"
            Begin Extent = 
               Top = 246
               Left = 522
               Bottom = 363
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeTiers"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 468
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Region"
            Begin Extent = 
               Top = 366
               Left = 280
               Bottom = 468
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 366
               Left = 522
               Bottom = 483
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 84
         End
         Begin Table = "FamilleTiers"
            Begin Extent = 
               Top = 468
               Left = 38
               Bottom = 585
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "Wilaya"
            Begin Extent = 
               Top = 468
               Left = 280
               Bottom = 570
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieTiers"
            Begin Extent = 
               Top = 486
               Left = 522
               Bottom = 603
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doc"
            Begin Extent = 
               Top = 570
               Left = 280
               Bottom = 642
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3315
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JRCF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JRCF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalEffet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 76
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 28
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1575
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JSCOM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JSCOM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalEffet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 76
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1740
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JSSPECIAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JSSPECIAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalEffet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 76
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JSTOCK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JSTOCK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[64] 4[9] 2[8] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TypeTiers"
            Begin Extent = 
               Top = 320
               Left = 611
               Bottom = 424
               Right = 811
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 124
               Left = 388
               Bottom = 243
               Right = 588
            End
            DisplayFlags = 280
            TopColumn = 55
         End
         Begin Table = "Produit"
            Begin Extent = 
               Top = 355
               Left = 580
               Bottom = 474
               Right = 780
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Lot"
            Begin Extent = 
               Top = 235
               Left = 316
               Bottom = 354
               Right = 516
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Task"
            Begin Extent = 
               Top = 98
               Left = 70
               Bottom = 217
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 17
         End
         Begin Table = "User_2"
            Begin Extent = 
               Top = 436
               Left = 60
               Bottom = 555
               Right = 260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 222
               Left = 38
               Bottom = 341
               Right = 238
            End
            DisplayFlags = 280
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTASK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     TopColumn = 0
         End
         Begin Table = "User_1"
            Begin Extent = 
               Top = 428
               Left = 291
               Bottom = 547
               Right = 491
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieTask"
            Begin Extent = 
               Top = 4
               Left = 43
               Bottom = 123
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NatureTask"
            Begin Extent = 
               Top = 6
               Left = 276
               Bottom = 110
               Right = 476
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EtatTask"
            Begin Extent = 
               Top = 6
               Left = 514
               Bottom = 110
               Right = 714
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Region"
            Begin Extent = 
               Top = 282
               Left = 609
               Bottom = 386
               Right = 809
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Wilaya"
            Begin Extent = 
               Top = 239
               Left = 607
               Bottom = 343
               Right = 807
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "CategorieTiers"
            Begin Extent = 
               Top = 194
               Left = 610
               Bottom = 313
               Right = 810
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "FamilleTiers"
            Begin Extent = 
               Top = 145
               Left = 613
               Bottom = 264
               Right = 813
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 19
         Width = 284
         Width = 1500
         Width = 1500
         Width = 2385
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3105
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTASK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTASK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[57] 4[9] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeTiers"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 108
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 123
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "derachat"
            Begin Extent = 
               Top = 108
               Left = 280
               Bottom = 195
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Solvabilite"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 243
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StatutTiers"
            Begin Extent = 
               Top = 126
               Left = 522
               Bottom = 228
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_2"
            Begin Extent = 
               Top = 198
               Left = 280
               Bottom = 315
               Right = 484
            End
            DisplayFlags = 2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTIERS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'80
            TopColumn = 0
         End
         Begin Table = "FamilleTiers"
            Begin Extent = 
               Top = 228
               Left = 522
               Bottom = 345
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tournee"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 363
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieTiers"
            Begin Extent = 
               Top = 318
               Left = 280
               Bottom = 435
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Region"
            Begin Extent = 
               Top = 348
               Left = 522
               Bottom = 450
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Vendeur"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 483
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_1"
            Begin Extent = 
               Top = 438
               Left = 280
               Bottom = 555
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_4"
            Begin Extent = 
               Top = 450
               Left = 522
               Bottom = 567
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Wilaya"
            Begin Extent = 
               Top = 486
               Left = 38
               Bottom = 588
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doc"
            Begin Extent = 
               Top = 558
               Left = 280
               Bottom = 675
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTIERS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTIERS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "TypeTiers"
            Begin Extent = 
               Top = 6
               Left = 276
               Bottom = 110
               Right = 476
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FamilleTiers"
            Begin Extent = 
               Top = 6
               Left = 514
               Bottom = 125
               Right = 714
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieTiers"
            Begin Extent = 
               Top = 114
               Left = 276
               Bottom = 233
               Right = 476
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Region"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 230
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Wilaya"
            Begin Extent = 
               Top = 234
               Left = 38
               Bottom = 338
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SousCompte"
            Begin Extent = 
               Top = 6
               Left = 752
               Bottom = 125
               Right = 952
            End
            DisplayFla' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTIERS2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'gs = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTIERS2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTIERS2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[44] 4[22] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -576
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Compte"
            Begin Extent = 
               Top = 390
               Left = 38
               Bottom = 507
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Transact"
            Begin Extent = 
               Top = 390
               Left = 280
               Bottom = 507
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doc"
            Begin Extent = 
               Top = 390
               Left = 532
               Bottom = 462
               Right = 736
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Compta"
            Begin Extent = 
               Top = 750
               Left = 38
               Bottom = 822
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dtrans"
            Begin Extent = 
               Top = 462
               Left = 532
               Bottom = 549
               Right = 736
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "demarcheur"
            Begin Extent = 
               Top = 582
               Left = 38
               Bottom = 699
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieTransaction"
            Begin Extent = 
               Top = 510
               Left = 280
               Bottom = 627
               Right = 505
            End
            Di' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTRANSACT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'splayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieTiers"
            Begin Extent = 
               Top = 552
               Left = 543
               Bottom = 669
               Right = 747
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 630
               Left = 38
               Bottom = 747
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 84
         End
         Begin Table = "Wilaya"
            Begin Extent = 
               Top = 630
               Left = 280
               Bottom = 732
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Region"
            Begin Extent = 
               Top = 672
               Left = 522
               Bottom = 774
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FamilleTiers"
            Begin Extent = 
               Top = 732
               Left = 280
               Bottom = 849
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 822
               Left = 38
               Bottom = 939
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Mode"
            Begin Extent = 
               Top = 774
               Left = 522
               Bottom = 891
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EtatTransaction"
            Begin Extent = 
               Top = 852
               Left = 280
               Bottom = 969
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTRANSACT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTRANSACT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[52] 4[18] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -384
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Mode"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Effet"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 64
         End
         Begin Table = "Depot_1"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 123
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 390
               Left = 38
               Bottom = 507
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_1"
            Begin Extent = 
               Top = 126
               Left = 280
               Bottom = 243
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Vehicule"
            Begin Extent = 
               Top = 126
               Left = 522
               Bottom = 243
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EtatEffet"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 363
               Right = 242
            End
            DisplayFlags = 280
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTRANSFERT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'         TopColumn = 0
         End
         Begin Table = "Depot"
            Begin Extent = 
               Top = 246
               Left = 280
               Bottom = 363
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieEffet"
            Begin Extent = 
               Top = 246
               Left = 522
               Bottom = 363
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User_2"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 483
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeTiers"
            Begin Extent = 
               Top = 366
               Left = 280
               Bottom = 468
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Region"
            Begin Extent = 
               Top = 366
               Left = 522
               Bottom = 468
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 480
               Left = 305
               Bottom = 597
               Right = 509
            End
            DisplayFlags = 280
            TopColumn = 84
         End
         Begin Table = "FamilleTiers"
            Begin Extent = 
               Top = 468
               Left = 522
               Bottom = 585
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Wilaya"
            Begin Extent = 
               Top = 486
               Left = 38
               Bottom = 588
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategorieTiers"
            Begin Extent = 
               Top = 588
               Left = 38
               Bottom = 705
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doc"
            Begin Extent = 
               Top = 588
               Left = 280
               Bottom = 660
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3555
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTRANSFERT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JTRANSFERT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalEffet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 76
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JournalEffetAll"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 70
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 63
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 15' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTEAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'00
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTEAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTEAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[14] 2[30] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OpComptoir"
            Begin Extent = 
               Top = 10
               Left = 17
               Bottom = 129
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 22
         End
         Begin Table = "EtatOpComptoir"
            Begin Extent = 
               Top = 94
               Left = 439
               Bottom = 213
               Right = 639
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GroupeComptoir"
            Begin Extent = 
               Top = 32
               Left = 443
               Bottom = 134
               Right = 647
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeOpComptoir"
            Begin Extent = 
               Top = 194
               Left = 38
               Bottom = 283
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Depot"
            Begin Extent = 
               Top = 169
               Left = 298
               Bottom = 288
               Right = 498
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CaisseComptoir"
            Begin Extent = 
               Top = 164
               Left = 533
               Bottom = 283
               Right = 733
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 31
               Left = 550
               Bottom = 150
               Right = 750
            End
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTECPT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'          DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 288
               Left = 38
               Bottom = 405
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 36
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2490
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTECPT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTECPT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[12] 2[32] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JVENTECPTLOT2"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 48
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 52
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Appen' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTECPTLOT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'd = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTECPTLOT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTECPTLOT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OpComptoir"
            Begin Extent = 
               Top = 0
               Left = 10
               Bottom = 117
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "GroupeComptoir"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 108
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DetailOpComptoirLot"
            Begin Extent = 
               Top = 0
               Left = 508
               Bottom = 117
               Right = 712
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Marque"
            Begin Extent = 
               Top = 6
               Left = 764
               Bottom = 108
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StatutLot"
            Begin Extent = 
               Top = 108
               Left = 280
               Bottom = 225
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeOpComptoir"
            Begin Extent = 
               Top = 108
               Left = 764
               Bottom = 195
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Depot"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 243
               Right = 242
            End
      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTECPTLOT2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EtatOpComptoir"
            Begin Extent = 
               Top = 126
               Left = 522
               Bottom = 243
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CaisseComptoir"
            Begin Extent = 
               Top = 198
               Left = 764
               Bottom = 315
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tiers"
            Begin Extent = 
               Top = 228
               Left = 280
               Bottom = 345
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 363
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTECPTLOT2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JVENTECPTLOT2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Lot"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DetailEffet"
            Begin Extent = 
               Top = 6
               Left = 301
               Bottom = 135
               Right = 526
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Effet"
            Begin Extent = 
               Top = 6
               Left = 564
               Bottom = 135
               Right = 789
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Lot_mvt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Lot_mvt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Effet"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "DetailEffet"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Lot"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 123
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 25
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'lotdouble'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'lotdouble'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "UpOperation"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PeriodeOperation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PeriodeOperation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "UpPaye"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PeriodePaye'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PeriodePaye'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "UpPoint"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PeriodePoint'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PeriodePoint'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[16] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Effet_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UniteProduction"
            Begin Extent = 
               Top = 152
               Left = 555
               Bottom = 269
               Right = 759
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Production"
            Begin Extent = 
               Top = 6
               Left = 764
               Bottom = 123
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Effet"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 243
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "JLot"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doc"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 78
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 37
         Width = 284
         Width = 1500
         Width = 1500
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductionJournal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductionJournal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductionJournal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Lot"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DetailEffet"
            Begin Extent = 
               Top = 6
               Left = 301
               Bottom = 135
               Right = 526
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Effet"
            Begin Extent = 
               Top = 6
               Left = 564
               Bottom = 135
               Right = 789
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Produit_mvt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Produit_mvt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Produit"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Lot"
            Begin Extent = 
               Top = 29
               Left = 413
               Bottom = 146
               Right = 617
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Taxe"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 363
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProduitLot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProduitLot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[20] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "User"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProfileStruct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProfileStruct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[37] 4[12] 2[28] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RealisationConvention'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RealisationConvention'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ConventionPalier"
            Begin Extent = 
               Top = 3
               Left = 364
               Bottom = 120
               Right = 568
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Real"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 108
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RealisationPalier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RealisationPalier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[37] 4[25] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ref"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 93
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 4365
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RegEffet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RegEffet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "LO"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'rp_Lot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'rp_Lot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[9] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Plan"
            Begin Extent = 
               Top = 6
               Left = 13
               Bottom = 123
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cour"
            Begin Extent = 
               Top = 118
               Left = 377
               Bottom = 235
               Right = 581
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Ouverture"
            Begin Extent = 
               Top = 0
               Left = 378
               Bottom = 117
               Right = 582
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1095
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'rptBalance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'rptBalance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Produit"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Emplacement"
            Begin Extent = 
               Top = 6
               Left = 276
               Bottom = 125
               Right = 476
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Lot"
            Begin Extent = 
               Top = 6
               Left = 514
               Bottom = 125
               Right = 714
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Marque"
            Begin Extent = 
               Top = 126
               Left = 276
               Bottom = 238
               Right = 485
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DetailInventaire"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 6
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'rptDetailInventaire'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'rptDetailInventaire'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'rptDetailInventaire'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "FamilleArticle"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dico"
            Begin Extent = 
               Top = 6
               Left = 276
               Bottom = 125
               Right = 476
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bsQteProduit"
            Begin Extent = 
               Top = 6
               Left = 514
               Bottom = 95
               Right = 714
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Produit"
            Begin Extent = 
               Top = 96
               Left = 514
               Bottom = 215
               Right = 714
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'rsProduit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'rsProduit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 3765
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TrancheEffet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TrancheEffet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 4590
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TrancheEffetCharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TrancheEffetCharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TypeEffetAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TypeEffetAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "User"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 48
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UserInfoEmp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UserInfoEmp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "User"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 123
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 24
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UserPme'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UserPme'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[15] 4[10] 2[26] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "journalcagnote"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 70
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JGCagnotte'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JGCagnotte'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JGCagnotte'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'HistTiersAffect'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'HistTiersAffect'
GO


