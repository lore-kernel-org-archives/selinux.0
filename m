Message-ID: <BAY22-F129FD32CC36DBE38C3B48BC0D30@phx.gbl>
In-Reply-To: <20060327145656.GB31654@sergelap.austin.ibm.com>
From: "Rongdong Lu" <qdmudong@hotmail.com>
To: SELinux@tycho.nsa.gov
Subject: Re: I am add a custom rule, know how 2 do te file, what about fc file, please he
Date: Tue, 28 Mar 2006 12:15:05 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the help,

Serge, Daniel and Stephen, it just became too complicated for me to handle, 
I finally disabled selinux.  It's such a waste of time in terms of 
progress(I am 2, 3 weeks behind my schedule because of selinux), but I did 
learn a lot about it.

Guess I will wait until a well tuned selinux comes out.

best,

Ron



>From: "Serge E. Hallyn" <serue@us.ibm.com>
>To: Rongdong Lu <qdmudong@hotmail.com>
>CC: SELinux@tycho.nsa.gov
>Subject: Re: I am add a custom rule, know how 2 do te file, what about fc 
>file, please help
>Date: Mon, 27 Mar 2006 08:56:56 -0600
>
>Quoting Rongdong Lu (qdmudong@hotmail.com):
> > Hi, List,
> >
> > Selinux has been driving me real crazy for the last serveral weeks, now
> > finally I'am getting some clue.
> >
> > Here's a problem i am having now. I have a centos4 server, with selinux
> > turned on, I can't use php to send out mail. I am using
> > selinux-policy-targeted-1.17.30-2.126. I am trying to add a custom rule 
>the
> > first time.
> >
> > here is the error messge in messages log:
> >
> > Mar 25 20:19:14 example kernel: audit(1143335954.882:36): avc:  denied  
>{
> > execute } for  pid=10036 comm="sh" name="sendmail" dev=sda5 ino=1228853
> > scontext=root:system_r:httpd_sys_script_t 
>tcontext=system_u:object_r:var_t
> > tclass=file
>
>You need to allow domain transitions from httpd_sys_script_t to
>sendmail_t.  Haven't used the old targeted in quite some time, but I
>think
>
>	file_type_auto_trans(httpd_sys_script_t, sendmail_exec_t, sendmail_t)
>
>should work.
>
>Except, looking at the old sources, that may not be right - sendmail_t
>is only for the daemon?
>
>Regardless, that's the sort of thing you need to fix - looks like no file
>contexts need to be changed.
>
> > Mar 25 20:19:14 example kernel: audit(1143335954.882:37): avc:  denied  
>{
> > getattr } for  pid=10036 comm="sh" name="sendmail" dev=sda5 ino=1228853
> > scontext=root:system_r:httpd_sys_script_t 
>tcontext=system_u:object_r:var_t
> > tclass=file
> >
> > I know I can use audit2allow to get the rule to add in to a te file, but
> > what do I add to the fc file? I couldn't find which is the command trys 
>to
> > access sendmail, a process with that pid one didn't exist after the 
>error
> > message is generated.
> >
> > any advice is appeciated, thanks in advance, guys
>
>-serge

_________________________________________________________________
On the road to retirement? Check out MSN Life Events for advice on how to 
get there! http://lifeevents.msn.com/category.aspx?cid=Retirement


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
