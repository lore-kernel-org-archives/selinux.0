From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Today's diffs
Date: Sat, 2 Oct 2004 03:57:05 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <415CAFC5.8020505@redhat.com> <415D799B.3060406@redhat.com> <200410020236.22248.russell@coker.com.au>
In-Reply-To: <200410020236.22248.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410020357.06006.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2 Oct 2004 02:36, Russell Coker <russell@coker.com.au> wrote:
> On Sat, 2 Oct 2004 01:36, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > >+# /usr/sbin/sendmail asks for w access to utmp
> > >+allow sendmail_t initrc_var_run_t:file { getattr read lock write };
> > >
> > >Why does sendmail need lock and write access to initrc_var_run_t?
> >
> > sm-client will not work without this.
>
> That turned out to be a bug in sendmail.fc.  I have attached a patch which
> fixes sendmail.fc and also removes the unnecessary rules from sendmail.te.

After further consideration I think that the correct solution is to have those 
files created under /var/run/sendmail/ .

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=134363

I have created a bugzilla entry about this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
