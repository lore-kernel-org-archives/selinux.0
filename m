MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help with semanage...
Date: Mon, 4 Jun 2007 18:12:21 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D0399F04E@de01exm68.ds.mot.com>
In-Reply-To: <1180993233.14220.171.camel@moss-spartans.epoch.ncsc.mil>
References: <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com> <1180633622.3534.78.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com> <20070531204502.3a667419@maya> <D06FE0A2807BC145B0D38744789D4F5D0399F027@de01exm68.ds.mot.com> <1180993233.14220.171.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Interesting. I am logged in as Linux_User = root,  and my SELinux role =
sysadm_r, domain = sysadm_t.

So Not sure how my security contexts could become incorrect ???

In any case, when I did  "/sbin/restorecon -R /etc/selinux"   it  DINDT
help  :(  Still got the same error.

BUT, just for kicks, I tried deleting the contents of the
/etc/selinux/strict/modules/previous/  directory, and then I was able to
run an semanage command for ONE more time !

So If I remove contents of the .../previous/  directory, then I can
execute one more semanage command successfully. So for successful
semanage commands I have to keep emptying out  .../previous/*. Very
Strange !

1. Is there anyway to run semanage or semodule commands such that a
"previous" directory is NOT created ?

2. What is the significance of the  semanage.read.LOCK  and
semanage.trans.LOCK  files ?

3. The fact the  /var/log/messages  file has a "python" error, does that
mean anything ?
   Jun  4 21:10:11 unknown python: Failed:  delete SELinux user mapping
name=Admin

4. Any foreseeable problems with getting rid of the
/etc/selinux/strict/modules/active/base.linked file ? I need to save
some space on my machine.

Thanks,

- Rezaul.


-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Monday, June 04, 2007 4:41 PM
To: Hasan Rezaul-CHR010
Cc: selinux@tycho.nsa.gov
Subject: Re: Help with semanage...

On Mon, 2007-06-04 at 17:30 -0400, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> I have a Linux machine (Machine_A) running a collection of  *strict*
> SELinux policies. On Machine_A, I am able to further modify policies
> by using semanage, and also add/delete policy modules using semodule.
> I can make changes at will successfully as many times as I want.
> 
> I tarred up the entire  /etc/selinux/* directory from Machine_A, and I
> untarred the tar-ball on another Linux machine, Machine_B. On
> Machine_B, I also created and mounted the /selinux/ directory. 
> 
> With all selinux files/dirs in place, AFTER rebooting Machine_B,
> SELinux policies seem to be working as expected !
> 
> At this point, I am able to execute  "semanage"  ONLY ONE time
> successfully !  Any attempts to make any further changes after the
> first time fails with the error below...
> 
> So for example, If I create a new user-mapping with:  "semanage login
> -a -s staff_u Admin", this first command is successful !
> 
> But every semanage command run afterwards has this same error:
> 
> semanage login -d Admin 
> Libsemanage.semanage_make_sandbox: Could not copy files to
> sandbox /etc/selinux/strict/modules/tmp 
> /usr/sbin/semanage: Could not start semanage transaction
> 
> The error message in the /var/log/messages file is: 
> Jun  4 21:10:11 unknown python: Failed:  delete SELinux user mapping
> name=Admin
> 
> Any ideas on why I can execute semanage only ONCE ?  I have tried
> rebooting the machine several times, to see if it helps, but it
> doesn't !
> 
> Also, whats the significance of
> the  /etc/selinux/strict/module/semanage.read.LOCK  &
> semanage.trans.LOCK   files ?

Run restorecon on /etc/selinux, e.g.
	/sbin/restorecon -R /etc/selinux

This usually happens when the file security contexts in /etc/selinux are
incorrect and permission is then denied to write to those directories.
That can happen if you e.g. run semanage or semodule without being in
the right domain in the first place.

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
