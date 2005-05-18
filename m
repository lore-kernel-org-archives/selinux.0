Message-ID: <428B2C7A.1050207@redhat.com>
Date: Wed, 18 May 2005 07:52:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: [Fwd: load_policy problem]
Content-Type: multipart/mixed;
 boundary="------------050807000406080306090600"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050807000406080306090600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

SELinux <SELinux@tycho.nsa.gov>

-- 



--------------050807000406080306090600
Content-Type: message/rfc822;
 name="load_policy problem"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="load_policy problem"

Return-Path: <hojatvaheb@yahoo.com>
Received: from mail.boston.redhat.com ([unix socket])
	by mail.boston.redhat.com (Cyrus v2.1.12) with LMTP; Sat, 14 May 2005 10:40:35 -0400
X-Sieve: CMU Sieve 2.2
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j4EEeZBA011344
	for <dwalsh@boston.redhat.com>; Sat, 14 May 2005 10:40:35 -0400
Received: from mx3.redhat.com (mx3.redhat.com [172.16.48.32])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j4EEeZO29693
	for <dwalsh@redhat.com>; Sat, 14 May 2005 10:40:35 -0400
Received: from web52105.mail.yahoo.com (web52105.mail.yahoo.com [206.190.39.74])
	by mx3.redhat.com (8.12.11/8.12.11) with SMTP id j4EEeSBD024904
	for <dwalsh@redhat.com>; Sat, 14 May 2005 10:40:28 -0400
Received: (qmail 32161 invoked by uid 60001); 14 May 2005 14:40:22 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=KhUO+wlKIuCoWRNJ51S07tWSgcYS6h0tms1On8zRndP/7BHRRJmwtLwHnVWSXDmmvKHZBaXGDy53FUFc/X/iirfwBAA/MjOKcW4UpyUFgVfOEcrH9V3aVT7faxla2TwY899NxdIgvhaDySqFmPS+TtOBk6hDluzl1NlLbOOieG0=  ;
Message-ID: <20050514144022.32159.qmail@web52105.mail.yahoo.com>
Received: from [62.220.96.232] by web52105.mail.yahoo.com via HTTP; Sat, 14 May 2005 07:40:22 PDT
Date: Sat, 14 May 2005 07:40:22 -0700 (PDT)
From: Hojat Vaheb <hojatvaheb@yahoo.com>
Subject: load_policy problem
To: dwalsh@redhat.com
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1658633096-1116081622=:27016"
X-RedHat-Spam-Score: 0.206 

--0-1658633096-1116081622=:27016
Content-Type: text/plain; charset=us-ascii


Hi. I added user “setest” with useradd command and then  I changed etc/selinux/strict/src/policy/users by adding following line:

{user_r second_r} user setest roles 

Then I added these lines to etc/selinux/strict/src/policy/domains/user.te: 

full_user_role(second)

allow system_r second_r

allow sysadm_r second_r

I changed etc/selinux/strict/src/policy/macros/user_macros.te as followes:

undefine ('in_user_role')

define('in_user_role' , '

role user_r types $1;

role second_r types $1;

')

Then I added  “second_r:second_t” to etc/selinux/strict/src/policy/appconfig/default_type and then I ran make command in directory etc /selinux/strict/src/policy/  and finally I ran load_policy policy.18 .

I did all above parts successfully except loading policy.18 because every time I ran load_policy command my computer hanged and I had to restart my computer.

what’s wrong?

Thanks.

What address should I use to broadcast  my mail among other members?

 

 

 

 

 

 

 

 

 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1658633096-1116081622=:27016
Content-Type: text/html; charset=us-ascii

<DIV>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'">Hi. I added user “setest” with </SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">useradd</SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'"> command and then<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>I changed <B>etc/selinux/strict/src/policy/users</B> by adding following line:<?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; TEXT-ALIGN: center; mso-layout-grid-align: none" align=center><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">{user_r second_r} user setest roles <o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'">Then I added these lines to <B>etc/selinux/strict/src/policy/domains/user.te</B>:</SPAN><B><I><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: TimesNewRomanPS-BoldItalicMT; mso-bidi-font-family: TimesNewRomanPS-BoldItalicMT"><FONT face="B Nazanin"> <o:p></o:p></FONT></SPAN></I></B></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; TEXT-ALIGN: center; mso-layout-grid-align: none" align=center><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">full_user_role(second)<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; TEXT-ALIGN: center; mso-layout-grid-align: none" align=center><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">allow system_r second_r<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; TEXT-ALIGN: center; mso-layout-grid-align: none" align=center><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">allow sysadm_r second_r<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'">I changed<B> etc/selinux/strict/src/policy/macros/user_macros.te</B> as followes:<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; TEXT-ALIGN: center; mso-layout-grid-align: none" align=center><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">undefine ('in_user_role')<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; TEXT-ALIGN: center; mso-layout-grid-align: none" align=center><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">define('in_user_role' , '<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; TEXT-ALIGN: center; mso-layout-grid-align: none" align=center><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">role user_r types $1;<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; TEXT-ALIGN: center; mso-layout-grid-align: none" align=center><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">role second_r types $1;<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; TEXT-ALIGN: center; mso-layout-grid-align: none" align=center><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">')<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'">Then I added<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>“</SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">second_r:second_t</SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'">” to <B>etc/selinux/strict/src/policy/appconfig/default_type</B> and then I ran </SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">make</SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'"> command in directory <B>etc /selinux/strict/src/policy/</B> <SPAN style="mso-spacerun: yes">&nbsp;</SPAN>and finally I ran </SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">load_policy policy.18 </SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'">.<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'">I did all above parts successfully except loading policy.18 because every time I ran </SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial">load_policy </SPAN><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'">command my computer hanged and I had to restart my computer.<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'">what’s wrong?<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'">Thanks.<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'">What address should I use to broadcast<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>my mail among other members?<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; TEXT-ALIGN: center; mso-layout-grid-align: none" align=center><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; TEXT-ALIGN: center; mso-layout-grid-align: none" align=center><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 14pt; FONT-FAMILY: 'Times New Roman'"><o:p>&nbsp;</o:p></SPAN></P></DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-1658633096-1116081622=:27016--

--------------050807000406080306090600--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
