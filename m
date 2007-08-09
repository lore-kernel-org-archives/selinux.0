Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79DlVvp000608
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 09:47:31 -0400
Received: from web32209.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l79DlTea012322
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:47:29 GMT
Date: Thu, 9 Aug 2007 06:47:29 -0700 (PDT)
From: Hal <hal_bg@yahoo.com>
Subject: Re: Strict policy in FC6 -  firefox does not start.
To: Stephen Smalley <sds@tycho.nsa.gov>, Kroum Antov <kroum@voicecho.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1186662541.6916.380.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <411126.53494.qm@web32209.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is the output in /var/log/messages, but there are no messages concerning
firefox or forefox-bin:

# before executing firefox
Aug  9 06:30:55 localhost kernel: audit(1186630255.888:33): avc:  denied  {
read } for  pid=2339 comm="cat" name="messages" dev=dm-0 ino=1436267
scontext=user_u:user_r:user_t:s0 tcontext=system_u:object_r:var_log_t:s0
tclass=file

#after starting firefox:
Aug  9 06:30:55 localhost kernel: audit(1186630255.888:33): avc:  denied  {
read } for  pid=2339 comm="cat" name="messages" dev=dm-0 ino=1436267
scontext=user_u:user_r:user_t:s0 tcontext=system_u:object_r:var_log_t:s0
tclass=file
Aug  9 06:31:10 localhost kernel: audit(1186630270.313:34): avc:  denied  {
read } for  pid=2351 comm="beagled-index-h" name="mono" dev=dm-0 ino=402358
scontext=user_u:user_r:user_t:s0 tcontext=system_u:object_r:mono_exec_t:s0
tclass=file
Aug  9 06:31:10 localhost kernel: audit(1186630270.313:35): avc:  denied  {
execute_no_trans } for  pid=2351 comm="beagled-index-h" name="mono" dev=dm-0
ino=402358 scontext=user_u:user_r:user_t:s0
tcontext=system_u:object_r:mono_exec_t:s0 tclass=file

regards 
Hal

--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2007-08-09 at 01:23 -0700, Kroum Antov wrote:
> > With Strict policy in FC6:  firefox does not start.
> > There are no messages at all. So I decided to check
> > if firefox works under strict policy on F7. 
> > I have installed F7 and enabled strict policy. But from now on I can't
> > longer login if enforcing is on . When I enter username and password
> > and 
> > I get "Authentication Failed" in GDM. In console I just get new
> > "username" prompt.
> > 
> > I do not understand why firefox does not start in fc6.
> > why I can not longin on F7 under strict policy?
> >  
> > What might be wrong?
> 
> Since Fedora ships with targeted policy by default, that is the policy
> that gets tested widely and is the only policy that gets tested by Red
> Hat as far as I know (except perhaps -mls, and that only for servers at
> present; no X support there).  Strict policy almost always requires some
> customization to make it work cleanly, which you can do by booting
> permissive and examining the avc denials, although you may need to
> install enableaudit.pp to see them all.  Please report the specific avc
> denials though (ausearch -m AVC -sv no if running auditd or grep
> avc /var/log/messages otherwise)
> 
> The good news is that targeted policy and strict policy are being merged
> together such that one can migrate gradually on the continuum from
> targeted policy to strict policy without completely replacing the
> policy.  That is work in progress, with experimental versions in F8
> IIUC.
>  
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



       
____________________________________________________________________________________
Got a little couch potato? 
Check out fun summer activities for kids.
http://search.yahoo.com/search?fr=oni_on_mail&p=summer+activities+for+kids&cs=bz 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
