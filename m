Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2DDqtBE012027
 for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2015 09:52:55 -0400
From: "Higgs, Stephen" <Stephen.Higgs@icfi.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: selinux category relabel (puppet)
Date: Fri, 13 Mar 2015 13:52:17 +0000
Message-ID: <2409d98630af4bc39108524e04557017@VNUCITEX02.ICFI.icfconsulting.com>
Content-Type: multipart/alternative;
 boundary="_000_2409d98630af4bc39108524e04557017VNUCITEX02ICFIicfconsul_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_2409d98630af4bc39108524e04557017VNUCITEX02ICFIicfconsul_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

If there is a more appropriate forum for this question please let me know:

I have a system that uses confined users by default and some files are mana=
ged by a puppet server.  When I run (via run_init) the puppet startup scrip=
t, I get the following avc log:

avc: denied { relabelto } for pid=3D30707 comm=3D"puppet" name=3D"crl.pem" =
dev=3Ddm-1 ino=3D527257 scontext=3Dsystem_u:system_r:puppet_t:s0 tcontext=
=3Dsystem_u:object_r:puppet_var_lib_t:s0:c0.c1023 tclass=3Dfile

I added "typeattribute puppet_t can_change_object_identity" and appropriate=
 "allow" statements to the puppet_t type after reading the constraints in t=
he targeted policy. However, it was the category "s0:c0.c1023" that was als=
o preventing puppet from relabeling the crl.pem file.

I was able to fix this by manually relabeling the file to "s0" instead of "=
s0:c0.c1023". My question is, how *should* I handle this so puppet can hand=
le the relabel of the category?

Stephen Higgs
ICF International

--_000_2409d98630af4bc39108524e04557017VNUCITEX02ICFIicfconsul_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"ProgId" content=3D"Word.Document">
<meta name=3D"Generator" content=3D"Microsoft Word 14">
<meta name=3D"Originator" content=3D"Microsoft Word 14">
<link rel=3D"File-List" href=3D"cid:filelist.xml@01D05D73.5FCBAC30"><!--[if=
 gte mso 9]><xml>
<o:OfficeDocumentSettings>
<o:AllowPNG/>
</o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
<w:WordDocument>
<w:Zoom>110</w:Zoom>
<w:SpellingState>Clean</w:SpellingState>
<w:TrackMoves/>
<w:TrackFormatting/>
<w:EnvelopeVis/>
<w:PunctuationKerning/>
<w:ValidateAgainstSchemas/>
<w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
<w:IgnoreMixedContent>false</w:IgnoreMixedContent>
<w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
<w:DoNotPromoteQF/>
<w:LidThemeOther>EN-US</w:LidThemeOther>
<w:LidThemeAsian>X-NONE</w:LidThemeAsian>
<w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
<w:Compatibility>
<w:BreakWrappedTables/>
<w:SnapToGridInCell/>
<w:WrapTextWithPunct/>
<w:UseAsianBreakRules/>
<w:DontGrowAutofit/>
<w:SplitPgBreakAndParaMark/>
<w:EnableOpenTypeKerning/>
<w:DontFlipMirrorIndents/>
<w:OverrideTableStyleHps/>
</w:Compatibility>
<m:mathPr>
<m:mathFont m:val=3D"Cambria Math"/>
<m:brkBin m:val=3D"before"/>
<m:brkBinSub m:val=3D"&#45;-"/>
<m:smallFrac m:val=3D"off"/>
<m:dispDef/>
<m:lMargin m:val=3D"0"/>
<m:rMargin m:val=3D"0"/>
<m:defJc m:val=3D"centerGroup"/>
<m:wrapIndent m:val=3D"1440"/>
<m:intLim m:val=3D"subSup"/>
<m:naryLim m:val=3D"undOvr"/>
</m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
<w:LatentStyles DefLockedState=3D"false" DefUnhideWhenUsed=3D"true" DefSemi=
Hidden=3D"true" DefQFormat=3D"false" DefPriority=3D"99" LatentStyleCount=3D=
"267">
<w:LsdException Locked=3D"false" Priority=3D"0" SemiHidden=3D"false" Unhide=
WhenUsed=3D"false" QFormat=3D"true" Name=3D"Normal"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"false" Unhide=
WhenUsed=3D"false" QFormat=3D"true" Name=3D"heading 1"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 2"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 3"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 4"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 5"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 6"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 7"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 8"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 9"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 1"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 2"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 3"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 4"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 5"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 6"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 7"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 8"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 9"/>
<w:LsdException Locked=3D"false" Priority=3D"35" QFormat=3D"true" Name=3D"c=
aption"/>
<w:LsdException Locked=3D"false" Priority=3D"10" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Title"/>
<w:LsdException Locked=3D"false" Priority=3D"1" Name=3D"Default Paragraph F=
ont"/>
<w:LsdException Locked=3D"false" Priority=3D"11" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtitle"/>
<w:LsdException Locked=3D"false" Priority=3D"22" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Strong"/>
<w:LsdException Locked=3D"false" Priority=3D"20" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"59" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Table Grid"/>
<w:LsdException Locked=3D"false" UnhideWhenUsed=3D"false" Name=3D"Placehold=
er Text"/>
<w:LsdException Locked=3D"false" Priority=3D"1" SemiHidden=3D"false" Unhide=
WhenUsed=3D"false" QFormat=3D"true" Name=3D"No Spacing"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1 Accent 1"/>
<w:LsdException Locked=3D"false" UnhideWhenUsed=3D"false" Name=3D"Revision"=
/>
<w:LsdException Locked=3D"false" Priority=3D"34" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"List Paragraph"/>
<w:LsdException Locked=3D"false" Priority=3D"29" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Quote"/>
<w:LsdException Locked=3D"false" Priority=3D"30" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Quote"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"19" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtle Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"21" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"31" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtle Reference"/>
<w:LsdException Locked=3D"false" Priority=3D"32" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Reference"/>
<w:LsdException Locked=3D"false" Priority=3D"33" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Book Title"/>
<w:LsdException Locked=3D"false" Priority=3D"37" Name=3D"Bibliography"/>
<w:LsdException Locked=3D"false" Priority=3D"39" QFormat=3D"true" Name=3D"T=
OC Heading"/>
</w:LatentStyles>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-alt:"Arial Rounded MT Bold";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1073786111 1 0 415 0;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-1593833729 1073750107 16 0 415 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 10]><style>/* Style Definitions */
table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-hansi-font-family:Calibri;}
</style><![endif]--><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"tab-interval:.=
5in">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If there is a more appropriate forum for this questi=
on please let me know:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have a system that uses confined users by default =
and some files are managed by a puppet server.<span style=3D"mso-spacerun:y=
es">&nbsp;
</span>When I run (via <span class=3D"SpellE">run_init</span>) the puppet s=
tartup script, I get the following
<span class=3D"SpellE">avc</span> log:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span class=3D"SpellE">avc</span>: denied { <span cl=
ass=3D"SpellE">
relabelto</span> } for <span class=3D"SpellE">pid</span>=3D30707 <span clas=
s=3D"SpellE">
comm</span>=3D&quot;puppet&quot; name=3D&quot;<span class=3D"SpellE">crl.pe=
m</span>&quot; <span class=3D"SpellE">
dev</span>=3Ddm-1 <span class=3D"SpellE">ino</span>=3D527257 <span class=3D=
"SpellE">scontext</span>=3Dsystem_u:system_r:puppet_t:s0
<span class=3D"SpellE">tcontext</span>=3Dsystem_u:object_r:puppet_var_lib_t=
:s0:c0.c1023
<span class=3D"SpellE">tclass</span>=3Dfile <br>
<br>
I added &quot;<span class=3D"SpellE">typeattribute</span> <span class=3D"Sp=
ellE">puppet_t</span>
<span class=3D"SpellE">can_change_object_identity</span>&quot; and appropri=
ate &quot;allow&quot; statements to the
<span class=3D"SpellE">puppet_t</span> type after reading the constraints i=
n the targeted policy. However, it was the category &#8220;s0:c0.c1023&#822=
1; that was also preventing puppet from relabeling the
<span class=3D"SpellE">crl.pem</span> file.<br>
<br>
I was able to fix this by manually relabeling the file to &quot;s0&quot; in=
stead of &quot;s0:c0.c1023&quot;. My question is, how *should* I handle thi=
s so puppet can handle the
<span class=3D"SpellE">relabel</span> of the category?<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-align:justify"><span style=3D"font-siz=
e:8.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-fareast-=
font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times Ne=
w Roman&quot;;color:black;mso-no-proof:yes"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-align:justify"><span style=3D"font-siz=
e:8.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-fareast-=
font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times Ne=
w Roman&quot;;color:black;mso-no-proof:yes">Stephen Higgs<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-align:justify"><span style=3D"font-siz=
e:8.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-fareast-=
font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times Ne=
w Roman&quot;;color:black;mso-no-proof:yes">ICF International<o:p></o:p></s=
pan></p>
</div>
</body>
</html>

--_000_2409d98630af4bc39108524e04557017VNUCITEX02ICFIicfconsul_--
