In-Reply-To: <401A5713.5010007@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Subject: selUpgrade RPMs
Message-ID: <OFB0E278F4.4A3FE8E5-ON49256E30.000A88B8-49256E30.000B740D@jp.ibm.com>
From: Tim Ebringer <EB17151@jp.ibm.com>
Date: Wed, 4 Feb 2004 11:05:05 +0900
Content-Type: multipart/alternative; boundary="=_alternative 000B740949256E30_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 000B740949256E30_=
Content-Type: text/plain; charset="US-ASCII"

Hi Dan,

I tried your selUpgrade script from a stock FC1 installation yesterday, 
but I found that I first needed to upgrade the following 4 rpms:
        tcl-8.4.5-3
        tk-8.4.5-3
        gaim-0.75-1
        db4-4.2.52-2
or else the non kernel RPM installation (line 45) choked on some 
dependencies.

Cheers,

Tim.





Daniel J Walsh <dwalsh@redhat.com>
Sent by: owner-selinux@tycho.nsa.gov
30/01/2004 10:07 PM
 
        To:     SELinux <SELinux@tycho.nsa.gov>
        cc: 
        Subject:        FYI: Arjan Kernel does not support SELinux


The latest kernel on people.redhat.com/~arjanv does not have the SELinux 
code turned on.  This was turned off a couple of versions ago, since 
SELinux will not be in RHEL4 Alpha1.  It will be in Alpha2 so it should 
be turned back on soon.  For the time being I have pulled the FC2 2.6 
kernel on to my people page which still supports SELinux.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
with
the words "unsubscribe selinux" without quotes as the message.


--=_alternative 000B740949256E30_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi Dan,</font>
<br>
<br><font size=2 face="sans-serif">I tried your selUpgrade script from
a stock FC1 installation yesterday, but I found that I first needed to
upgrade the following 4 rpms:</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; tcl-8.4.5-3</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; tk-8.4.5-3</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; gaim-0.75-1</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; db4-4.2.52-2</font>
<br><font size=2 face="sans-serif">or else the non kernel RPM installation
(line 45) choked on some dependencies.</font>
<br>
<br><font size=2 face="sans-serif">Cheers,</font>
<br>
<br><font size=2 face="sans-serif">Tim.</font>
<br>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td>
<td><font size=1 face="sans-serif"><b>Daniel J Walsh &lt;dwalsh@redhat.com&gt;</b></font>
<br><font size=1 face="sans-serif">Sent by: owner-selinux@tycho.nsa.gov</font>
<p><font size=1 face="sans-serif">30/01/2004 10:07 PM</font>
<td><font size=1 face="Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; To:
&nbsp; &nbsp; &nbsp; &nbsp;SELinux &lt;SELinux@tycho.nsa.gov&gt;</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc:
&nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Subject:
&nbsp; &nbsp; &nbsp; &nbsp;FYI: Arjan Kernel does not support SELinux</font></table>
<br>
<br>
<br><font size=2><tt>The latest kernel on people.redhat.com/~arjanv does
not have the SELinux <br>
code turned on. &nbsp;This was turned off a couple of versions ago, since
<br>
SELinux will not be in RHEL4 Alpha1. &nbsp;It will be in Alpha2 so it should
<br>
be turned back on soon. &nbsp;For the time being I have pulled the FC2
2.6 <br>
kernel on to my people page which still supports SELinux.<br>
<br>
Dan<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br>
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br>
</tt></font>
<br>
--=_alternative 000B740949256E30_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
