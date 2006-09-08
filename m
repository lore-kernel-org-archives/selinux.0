From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Steve G <linux_4ever@yahoo.com>
Subject: Re: IPC security context
Date: Fri, 8 Sep 2006 10:05:34 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>, andy.suchoski@comcast.net,
        selinux@tycho.nsa.gov
References: <20060907210503.73467.qmail@web51510.mail.yahoo.com>
In-Reply-To: <20060907210503.73467.qmail@web51510.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609081005.37716.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 September 2006 07:05, Steve G <linux_4ever@yahoo.com> wrote:
> >To re-add, we would need a specific application that required such
> > support.
>
> Would ipcs be that app?

I believe so.

I am currently working on writing policy for some proprietary software that 
uses a lot of shared memory and semaphores.  The inability to display 
contexts through ipcs is a significant obstacle for me in this work.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
