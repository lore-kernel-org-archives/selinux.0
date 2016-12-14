Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBEDCas3014646
 for <selinux@tycho.nsa.gov>; Wed, 14 Dec 2016 08:12:36 -0500
Subject: Re: Possible SELinux problem on Fedora 25 Install
To: "Parker, Michael D." <Michael.D.Parker@ga.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <fc9b755857cd4bffa582fcac7ea2e574@ASGEXCPWP01.ga.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <fc879540-0a81-573e-4def-085079ad9528@redhat.com>
Date: Wed, 14 Dec 2016 08:12:31 -0500
MIME-Version: 1.0
In-Reply-To: <fc9b755857cd4bffa582fcac7ea2e574@ASGEXCPWP01.ga.com>
Content-Type: multipart/alternative;
 boundary="------------D9DC2DD19B06C2ED8BC8E89D"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------D9DC2DD19B06C2ED8BC8E89D
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

This should be fixed by updating to the latest container-selinux package.

container-selinux-1.12.4-5.git1b5971a.fc25.noarch.rpm

Then  you can

dnf reinstall selinux-policy


ls
On 12/13/2016 02:55 PM, Parker, Michael D. wrote:
>
> I am getting the following messages during the last update concerning
> SELinux packages…..I do a pretty much vanilla install here and have
> not modified any SELinux functionality…..should I be concerned?
>
>  
>
> *  Upgrading   : selinux-policy-3.13.1-225.3.fc25.noarch 
>                                                                       1/38*
>
> *Re-declaration of boolean virt_sandbox_use_fusefs*
>
> *Failed to create node*
>
> *Bad boolean declaration at
> /var/lib/selinux/targeted/tmp/modules/100/virt/cil:152*
>
> *semodule:  Failed!*
>
>   Upgrading   :
> samba-common-2:4.5.2-0.fc25.noarch                                                                            
> 2/38
>
>   Upgrading   :
> libwbclient-2:4.5.2-0.fc25.x86_64                                                                             
> 3/38
>
>   Upgrading   :
> samba-client-libs-2:4.5.2-0.fc25.x86_64                                                                       
> 4/38
>
>   Installing  :
> kernel-core-4.8.13-300.fc25.x86_64                                                                         
>    5/38
>
>   Installing  :
> kernel-modules-4.8.13-300.fc25.x86_64                                                                         
> 6/38
>
>   *Upgrading   :
> selinux-policy-targeted-3.13.1-225.3.fc25.noarch                                                   
>            7/38*
>
> *Re-declaration of boolean virt_sandbox_use_fusefs*
>
> *Failed to create node*
>
> *Bad boolean declaration at
> /var/lib/selinux/targeted/tmp/modules/100/virt/cil:152*
>
> */usr/sbin/semodule:  Failed!*
>
>   Upgrading   : pcsc-lite-libs-1.8.19-1.fc25.x86_64     
>                                                                       8/38
>
>   Upgrading   :
> pcsc-lite-1.8.19-1.fc25.x86_64                                                                                
> 9/38
>
>   *Upgrading   :
> selinux-policy-sandbox-3.13.1-225.3.fc25.noarch                                                              
> 10/38*
>
> *Re-declaration of boolean virt_sandbox_use_fusefs*
>
> *Failed to create node*
>
> *Bad boolean declaration at
> /var/lib/selinux/targeted/tmp/modules/100/virt/cil:152*
>
> *semodule:  Failed!*
>
>   Installing  :
> kernel-4.8.13-300.fc25.x86_64                                                                                
> 11/38
>
>   Upgrading   :
> libsmbclient-2:4.5.2-0.fc25.x86_64                                                                         
>   12/38
>
>   Upgrading   :
> selinux-policy-mls-3.13.1-225.3.fc25.noarch                                                                  
> 13/38
>
>   *Upgrading   :
> selinux-policy-minimum-3.13.1-225.3.fc25.noarch                                                    
>           14/38*
>
> *Failed to resolve typeattributeset statement at
> /var/lib/selinux/minimum/tmp/modules/100/xserver/cil:472*
>
> */usr/sbin/semodule:  Failed!*
>
>  
>
> ***** ***** *****
>
> Michael D. Parker
>
> General Atomics – ElectroMagnetics Systems Division (EMS)
>
> Michael.d.parker@ga.com <mailto:Michael.d.parker@ga.com>  *<<<<< NOTE:
> Remember to include my middle initial >>>>>*
>
> +1 858 964 6675 / Office 86-1319 / Cell +1 858 376 7474
>
> 16969 Mesamint Street / San Diego / CA / 92127
>
>  
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--------------D9DC2DD19B06C2ED8BC8E89D
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>This should be fixed by updating to the latest container-selinux
      package.</p>
    <p>container-selinux-1.12.4-5.git1b5971a.fc25.noarch.rpm<br>
    </p>
    <p>Then  you can <br>
    </p>
    <p>dnf reinstall selinux-policy</p>
    <p><br>
    </p>
    ls <br>
    <div class="moz-cite-prefix">On 12/13/2016 02:55 PM, Parker, Michael
      D. wrote:<br>
    </div>
    <blockquote
      cite="mid:fc9b755857cd4bffa582fcac7ea2e574@ASGEXCPWP01.ga.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Comic Sans MS";
	panose-1:3 15 7 2 3 3 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal">I am getting the following messages during
          the last update concerning SELinux packages…..I do a pretty
          much vanilla install here and have not modified any SELinux
          functionality…..should I be concerned?<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">  Upgrading   :
              selinux-policy-3.13.1-225.3.fc25.noarch 
                                                                      1/38<o:p></o:p></span></b></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">Re-declaration of boolean
              virt_sandbox_use_fusefs<o:p></o:p></span></b></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">Failed to create node<o:p></o:p></span></b></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">Bad boolean declaration at
              /var/lib/selinux/targeted/tmp/modules/100/virt/cil:152<o:p></o:p></span></b></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">semodule:  Failed!<o:p></o:p></span></b></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  Upgrading   :
samba-common-2:4.5.2-0.fc25.noarch                                                                            
            2/38<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  Upgrading   :
libwbclient-2:4.5.2-0.fc25.x86_64                                                                             
            3/38<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  Upgrading   :
samba-client-libs-2:4.5.2-0.fc25.x86_64                                                                       
            4/38<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  Installing  :
kernel-core-4.8.13-300.fc25.x86_64                                                                         
               5/38<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  Installing  :
kernel-modules-4.8.13-300.fc25.x86_64                                                                         
            6/38<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  <b><span style="color:red">Upgrading   :
selinux-policy-targeted-3.13.1-225.3.fc25.noarch                                                   
                           7/38<o:p></o:p></span></b></span></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">Re-declaration of boolean
              virt_sandbox_use_fusefs<o:p></o:p></span></b></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">Failed to create node<o:p></o:p></span></b></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">Bad boolean declaration at
              /var/lib/selinux/targeted/tmp/modules/100/virt/cil:152<o:p></o:p></span></b></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">/usr/sbin/semodule:  Failed!<o:p></o:p></span></b></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  Upgrading   :
            pcsc-lite-libs-1.8.19-1.fc25.x86_64     
                                                                      8/38<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  Upgrading   :
pcsc-lite-1.8.19-1.fc25.x86_64                                                                                
            9/38<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  <b><span style="color:red">Upgrading   :
selinux-policy-sandbox-3.13.1-225.3.fc25.noarch                                                              
                10/38<o:p></o:p></span></b></span></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">Re-declaration of boolean
              virt_sandbox_use_fusefs<o:p></o:p></span></b></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">Failed to create node<o:p></o:p></span></b></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">Bad boolean declaration at
              /var/lib/selinux/targeted/tmp/modules/100/virt/cil:152<o:p></o:p></span></b></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">semodule:  Failed!<o:p></o:p></span></b></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  Installing  :
kernel-4.8.13-300.fc25.x86_64                                                                                
            11/38<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  Upgrading   :
libsmbclient-2:4.5.2-0.fc25.x86_64                                                                         
              12/38<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  Upgrading   :
selinux-policy-mls-3.13.1-225.3.fc25.noarch                                                                  
            13/38<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Courier
            New&quot;">  <b><span style="color:red">Upgrading   :
selinux-policy-minimum-3.13.1-225.3.fc25.noarch                                                    
                          14/38<o:p></o:p></span></b></span></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">Failed to resolve typeattributeset
              statement at
              /var/lib/selinux/minimum/tmp/modules/100/xserver/cil:472<o:p></o:p></span></b></p>
        <p class="MsoNormal"><b><span style="font-family:&quot;Courier
              New&quot;;color:red">/usr/sbin/semodule:  Failed!<o:p></o:p></span></b></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal"><span style="font-family:&quot;Comic Sans
            MS&quot;">***** ***** *****<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Comic Sans
            MS&quot;">Michael D. Parker<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Comic Sans
            MS&quot;">General Atomics – ElectroMagnetics Systems
            Division (EMS)<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Comic Sans
            MS&quot;"><a moz-do-not-send="true"
              href="mailto:Michael.d.parker@ga.com"><span
                style="color:#0563C1">Michael.d.parker@ga.com</span></a> 
            <b>&lt;&lt;&lt;&lt;&lt; NOTE: Remember to include my middle
              initial &gt;&gt;&gt;&gt;&gt;<o:p></o:p></b></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Comic Sans
            MS&quot;">+1 858 964 6675 / Office 86-1319 / Cell +1 858 376
            7474<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Comic Sans
            MS&quot;">16969 Mesamint Street / San Diego / CA / 92127<o:p></o:p></span></p>
        <p class="MsoNormal"><o:p> </o:p></p>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Selinux mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------D9DC2DD19B06C2ED8BC8E89D--
