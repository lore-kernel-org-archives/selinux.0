In-Reply-To: <20100508075904.GB3075@localhost.localdomain>
References: <OF4B777D47.6A3F031D-ON8525771C.00694668-8525771C.0070353C@vpcl.on.ca> <20100508075904.GB3075@localhost.localdomain>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: Selinux and Apache in chroot question....
Message-ID: <OFF8CFA4DF.E6184554-ON8525771F.0048E817-8525771F.004AB5C5@vpcl.on.ca>
From: fred.schnittke@vpcl.on.ca
Date: Mon, 10 May 2010 09:35:53 -0400
Content-Type: multipart/alternative; boundary="=_alternative 004AB5C38525771F_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 004AB5C38525771F_=
Content-Type: text/plain; charset="US-ASCII"

Thanks Dominick:

So do I have to go through and see what the file context(s) were for the 
files in the old locations, then manually make the corresponding files in 
the chroot the same? I don't suppose doing a relabel of the entire OS 
would help me out?

Thanks....
 
 
Regards, 
 
 
Fred Schnittke  MCSE, MCP,
Network Engineer
VETERINARY PURCHASING company limited



Dominick Grift <domg472@gmail.com> 
Sent by: owner-selinux@tycho.nsa.gov
05/08/2010 03:59 AM

To
SELinux@tycho.nsa.gov
cc

Subject
Re: Selinux and Apache in chroot question....






On Fri, May 07, 2010 at 04:25:35PM -0400, fred.schnittke@vpcl.on.ca wrote:
> Hi:
> 
> Not sure if this is the right place to post a question like this, but 
I'll 
> give it a shot.
> 
> I've been following the "Guide to the Secure Configuration of Red Hat 
> Enterprise Linux 5" (which has been a great resource) in setting up our 
> new server. However I ran into problems chrooting, apache, php and 
mysql. 
> So it was suggested to remove the applications and compile from source. 
> After that was done, I moved the three applications to my chroot, and 
with 
> a bit of effort, it all works. The only thing is, I don't think SELINUX 
is 
> monitoring any of the files in the chroot. For instance, it still thinks 

> the web directory is in /var/www/ instead of 
/chroot/httpd/usr/local/www.
> 
> When I run the following command: 
> 
> ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | tr ':' ' ' 
| 
> awk '{ print $NF }'

SELinux is much about the labeling of objects. File context 
specifications, specify what label to assign to what object in what 
location.
By chrooting apache and mysql, you change their objects locations. Which 
in this case SElinux seems not aware about.

The only objects that remain in place is the services init script. When 
init runs an init script the init domain, domain transitions to the init 
script domain.
The init script domain would usually transition to the service domain, if 
the service domain executable file is properly labeled.

The init script domain is unrestricted and unprotected.

So what is happening is the following.

You have moved objects owned by apache and mysql to a new mountpoint 
called /chroot. 
The command: semanage fcontext -l | grep /chroot, tells us that there is 
currently no context specified for this location.

Thus the location would be labeled either default_t or root_t.

you start the service, init transitions to the unconfined init script 
domain initrc_t and initrc_t, the init script executes the apache /mysql 
executable file which is somewhere in /chroot and labeled with a generic 
type for unspecified locations. Thus initrc_t does not domain transition 
to the apache/mysql domain as it would usually do if the apache/mysql 
executable files were labeled properly. So you end up with a chrooted 
services but you lost selinux protection.


To solve this issue you must change the labeling to reflect their usual 
location. You can list contexts of the various object using semanage 
fcontext -l and use similar command to add, modify, delete file context 
entries.



> 
> I get this output:
> 
> mysqld
> httpd
> httpd
> httpd
> httpd
> httpd
> httpd
> httpd
> httpd
> 
> So my question is:
> 
> Is there a (an easy) way to confine these daemons?
> 
> 
> Regards, 
> 
> 
> Fred Schnittke  MCSE, MCP,
> Network Engineer
> VETERINARY PURCHASING company limited


--=_alternative 004AB5C38525771F_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Thanks Dominick:</font>
<br>
<br><font size=2 face="sans-serif">So do I have to go through and see what
the file context(s) were for the files in the old locations, then manually
make the corresponding files in the chroot the same? I don't suppose doing
a relabel of the entire OS would help me out?</font>
<br>
<br><font size=2 face="sans-serif">Thanks....</font>
<br><font size=2 face="Arial">&nbsp;</font>
<p><font size=2 face="Arial">&nbsp;</font>
<p><font size=2 face="Arial">Regards, </font>
<p><font size=2 face="Arial">&nbsp;</font>
<p><font size=3>&nbsp;</font>
<p><font size=2 face="Arial"><b>Fred Schnittke</b></font><font size=1 color=#808080 face="Arial">
</font><font size=1 color=blue face="Arial">&nbsp;MCSE, MCP,</font><font size=1 color=#808080 face="Arial"><b><br>
Network Engineer</b><br>
VETERINARY PURCHASING company limited<br>
</font>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="Arial"><b>Dominick Grift &lt;domg472@gmail.com&gt;</b>
</font>
<br><font size=1 face="Arial">Sent by: owner-selinux@tycho.nsa.gov</font>
<p><font size=1 face="Arial">05/08/2010 03:59 AM</font>
<td width=59%>
<table width=100%>
<tr>
<td>
<div align=right><font size=1 face="Arial">To</font></div>
<td valign=top><font size=1 face="Arial">SELinux@tycho.nsa.gov</font>
<tr>
<td>
<div align=right><font size=1 face="Arial">cc</font></div>
<td valign=top>
<tr>
<td>
<div align=right><font size=1 face="Arial">Subject</font></div>
<td valign=top><font size=1 face="Arial">Re: Selinux and Apache in chroot
question....</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2>On Fri, May 07, 2010 at 04:25:35PM -0400, fred.schnittke@vpcl.on.ca
wrote:<br>
&gt; Hi:<br>
&gt; <br>
&gt; Not sure if this is the right place to post a question like this,
but I'll <br>
&gt; give it a shot.<br>
&gt; <br>
&gt; I've been following the &quot;Guide to the Secure Configuration of
Red Hat <br>
&gt; Enterprise Linux 5&quot; (which has been a great resource) in setting
up our <br>
&gt; new server. However I ran into problems chrooting, apache, php and
mysql. <br>
&gt; So it was suggested to remove the applications and compile from source.
<br>
&gt; After that was done, I moved the three applications to my chroot,
and with <br>
&gt; a bit of effort, it all works. The only thing is, I don't think SELINUX
is <br>
&gt; monitoring any of the files in the chroot. For instance, it still
thinks <br>
&gt; the web directory is in /var/www/ instead of /chroot/httpd/usr/local/www.<br>
&gt; <br>
&gt; When I run the following command: <br>
&gt; <br>
&gt; ps -eZ | egrep &quot;initrc&quot; | egrep -vw &quot;tr|ps|egrep|bash|awk&quot;
| tr ':' ' ' | <br>
&gt; awk '{ print $NF }'<br>
<br>
SELinux is much about the labeling of objects. File context specifications,
specify what label to assign to what object in what location.<br>
By chrooting apache and mysql, you change their objects locations. Which
in this case SElinux seems not aware about.<br>
<br>
The only objects that remain in place is the services init script. When
init runs an init script the init domain, domain transitions to the init
script domain.<br>
The init script domain would usually transition to the service domain,
if the service domain executable file is properly labeled.<br>
<br>
The init script domain is unrestricted and unprotected.<br>
<br>
So what is happening is the following.<br>
<br>
You have moved objects owned by apache and mysql to a new mountpoint called
/chroot. <br>
The command: semanage fcontext -l | grep /chroot, tells us that there is
currently no context specified for this location.<br>
<br>
Thus the location would be labeled either default_t or root_t.<br>
<br>
you start the service, init transitions to the unconfined init script domain
initrc_t and initrc_t, the init script executes the apache /mysql executable
file which is somewhere in /chroot and labeled with a generic type for
unspecified locations. Thus initrc_t does not domain transition to the
apache/mysql domain as it would usually do if the apache/mysql executable
files were labeled properly. So you end up with a chrooted services but
you lost selinux protection.<br>
<br>
<br>
To solve this issue you must change the labeling to reflect their usual
location. You can list contexts of the various object using semanage fcontext
-l and use similar command to add, modify, delete file context entries.<br>
<br>
<br>
<br>
&gt; <br>
&gt; I get this output:<br>
&gt; <br>
&gt; mysqld<br>
&gt; httpd<br>
&gt; httpd<br>
&gt; httpd<br>
&gt; httpd<br>
&gt; httpd<br>
&gt; httpd<br>
&gt; httpd<br>
&gt; httpd<br>
&gt; &nbsp;<br>
&gt; So my question is:<br>
&gt; <br>
&gt; Is there a (an easy) way to confine these daemons?<br>
&gt; <br>
&gt; &nbsp;<br>
&gt; Regards, <br>
&gt; &nbsp;<br>
&gt; &nbsp;<br>
&gt; Fred Schnittke &nbsp;MCSE, MCP,<br>
&gt; Network Engineer<br>
&gt; VETERINARY PURCHASING company limited<br>
</font></tt>
<br>
--=_alternative 004AB5C38525771F_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
