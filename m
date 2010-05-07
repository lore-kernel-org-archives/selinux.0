MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Selinux and Apache in chroot question....
Message-ID: <OF4B777D47.6A3F031D-ON8525771C.00694668-8525771C.0070353C@vpcl.on.ca>
From: fred.schnittke@vpcl.on.ca
Date: Fri, 7 May 2010 16:25:35 -0400
Content-Type: multipart/alternative; boundary="=_alternative 0070353A8525771C_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 0070353A8525771C_=
Content-Type: text/plain; charset="US-ASCII"

Hi:

Not sure if this is the right place to post a question like this, but I'll 
give it a shot.

I've been following the "Guide to the Secure Configuration of Red Hat 
Enterprise Linux 5" (which has been a great resource) in setting up our 
new server. However I ran into problems chrooting, apache, php and mysql. 
So it was suggested to remove the applications and compile from source. 
After that was done, I moved the three applications to my chroot, and with 
a bit of effort, it all works. The only thing is, I don't think SELINUX is 
monitoring any of the files in the chroot. For instance, it still thinks 
the web directory is in /var/www/ instead of /chroot/httpd/usr/local/www.

When I run the following command: 

ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | tr ':' ' ' | 
awk '{ print $NF }'

I get this output:

mysqld
httpd
httpd
httpd
httpd
httpd
httpd
httpd
httpd
 
So my question is:

Is there a (an easy) way to confine these daemons?

 
Regards, 
 
 
Fred Schnittke  MCSE, MCP,
Network Engineer
VETERINARY PURCHASING company limited
--=_alternative 0070353A8525771C_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="Arial">Hi:</font>
<br>
<br><font size=2 face="Arial">Not sure if this is the right place to post
a question like this, but I'll give it a shot.</font>
<br>
<br><font size=2 face="Arial">I've been following the &quot;Guide to the
Secure Configuration of Red Hat Enterprise Linux 5&quot; (which has been
a great resource) in setting up our new server. However I ran into problems
chrooting, apache, php and mysql. So it was suggested to remove the applications
and compile from source. After that was done, I moved the three applications
to my chroot, and with a bit of effort, it all works. The only thing is,
I don't think SELINUX is monitoring any of the files in the chroot. For
instance, it still thinks the web directory is in /var/www/ instead of
/chroot/httpd/usr/local/www.</font>
<br>
<br><font size=2 face="Arial">When I run the following command: </font>
<br>
<br><font size=2 face="Courier New">ps -eZ | egrep &quot;initrc&quot; |
egrep -vw &quot;tr|ps|egrep|bash|awk&quot; | tr ':' ' ' | awk '{ print
$NF }'</font>
<br>
<br><font size=2 face="Arial">I get this output:</font>
<br>
<br><font size=2 face="Courier New">mysqld</font>
<br><font size=2 face="Courier New">httpd</font>
<br><font size=2 face="Courier New">httpd</font>
<br><font size=2 face="Courier New">httpd</font>
<br><font size=2 face="Courier New">httpd</font>
<br><font size=2 face="Courier New">httpd</font>
<br><font size=2 face="Courier New">httpd</font>
<br><font size=2 face="Courier New">httpd</font>
<br><font size=2 face="Courier New">httpd</font>
<br><font size=2 face="Arial">&nbsp;</font>
<br><font size=2 face="Arial">So my question is:</font>
<br>
<br><font size=2 face="Arial">Is there a (an easy) way to confine these
daemons?</font>
<p>
<p><font size=2 face="Arial">&nbsp;</font>
<p><font size=2 face="Arial">Regards, </font>
<p><font size=2 face="Arial">&nbsp;</font>
<p><font size=3>&nbsp;</font>
<p><font size=2 face="Arial"><b>Fred Schnittke</b></font><font size=1 color=#808080 face="Arial">
</font><font size=1 color=blue face="Arial">&nbsp;MCSE, MCP,</font><font size=1 color=#808080 face="Arial"><b><br>
Network Engineer</b><br>
VETERINARY PURCHASING company limited</font>
--=_alternative 0070353A8525771C_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
