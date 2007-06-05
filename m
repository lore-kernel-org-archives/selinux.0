MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help with semanage...
Date: Tue, 5 Jun 2007 12:34:54 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D0399F30B@de01exm68.ds.mot.com>
In-Reply-To: <1181048822.25769.23.camel@moss-spartans.epoch.ncsc.mil>
References: <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com> <1180633622.3534.78.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com> <20070531204502.3a667419@maya> <D06FE0A2807BC145B0D38744789D4F5D0399F027@de01exm68.ds.mot.com> <1180993233.14220.171.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D0399F04E@de01exm68.ds.mot.com> <1181048822.25769.23.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The version of libsemanage I have is:   libsemanage-1.6.17-1

1. What specific version of libsemanage  removes the use of the
..../previous/  directory, as well as the  .../active/base.linked  files
?

2. Would I need a newer version of some other library(ies) as well (like
libselinux, etc), so that executing semodule commands doesn't create a
.../previous/  directory ?  Example commands: 
"semodule -i myPolicy.pp"    -or-    "semodule -r myPolicy" 

3. Any explanations of why  emptying out the .../previous/*  directory
allows me to execute another semanage command successfully ?

Thanks,

- Rezaul.  


-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Tuesday, June 05, 2007 8:07 AM
To: Hasan Rezaul-CHR010
Cc: selinux@tycho.nsa.gov
Subject: RE: Help with semanage...

On Mon, 2007-06-04 at 18:12 -0400, Hasan Rezaul-CHR010 wrote:
> Interesting. I am logged in as Linux_User = root,  and my SELinux role
=
> sysadm_r, domain = sysadm_t.
> 
> So Not sure how my security contexts could become incorrect ???
> 
> In any case, when I did  "/sbin/restorecon -R /etc/selinux"   it
DINDT
> help  :(  Still got the same error.

And what avc messages are you getting in /var/log/messages
or /var/log/audit/audit.log?

> BUT, just for kicks, I tried deleting the contents of the
> /etc/selinux/strict/modules/previous/  directory, and then I was able
to
> run an semanage command for ONE more time !
> 
> So If I remove contents of the .../previous/  directory, then I can
> execute one more semanage command successfully. So for successful
> semanage commands I have to keep emptying out  .../previous/*. Very
> Strange !
> 
> 1. Is there anyway to run semanage or semodule commands such that a
> "previous" directory is NOT created ?

Update libsemanage to a recent version.  What version do you presently
have?

> 2. What is the significance of the  semanage.read.LOCK  and
> semanage.trans.LOCK  files ?

libsemanage performs flock(3) calls on them to perform locking on the
policy store.  The mere existence of the files means nothing (i.e. their
existence does not imply that anything is locked).

> 3. The fact the  /var/log/messages  file has a "python" error, does
that
> mean anything ?

That is just how log messages from a python script like semanage
manifest, since the real program is the python interpreter.

>    Jun  4 21:10:11 unknown python: Failed:  delete SELinux user
mapping
> name=Admin
> 
> 4. Any foreseeable problems with getting rid of the
> /etc/selinux/strict/modules/active/base.linked file ? I need to save
> some space on my machine.

If you update to a newer libsemanage, it shouldn't be left around
anymore.

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
