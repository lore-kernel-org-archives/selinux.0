From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Nagendra Tomar <tomer_iisc@yahoo.com>
Subject: Re: Fwd: "star -xattr" in SELinux enabled system
Date: Tue, 12 Jun 2007 18:36:53 +1000
Cc: SELinux@tycho.nsa.gov
References: <727001.44086.qm@web53702.mail.re2.yahoo.com>
In-Reply-To: <727001.44086.qm@web53702.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706121836.55126.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 10 June 2007 14:29, Nagendra Tomar <tomer_iisc@yahoo.com> wrote:
> > Sometimes the "least privilege" for an application is to allow it to do
> > almost anything.
>
> ???? Can you pls explain this ?

For example sysadm_t in the strict policy.  The range of tasks performed by 
the sys-admin in regular operation includes everything that a hostile process 
might want to do.

BTW  Please make sure you clearly indicate who wrote each piece of text.  
Failing to do so confuses people who are trying to follow the discussion, is 
a copyright violation, and may be considered to be libel.

It is easies for you to correctly indicate the level of quoting when replying 
to me as it is for me to fix things up when replying to your message.

> > I agree that it makes sense to restrict things as much as possible.  But
> > when you have data coming from a trusted source the benefits are minimal. 
> > You could of course have a domain that has minimal access to other
> > processes but full access to all files on disk.
>
> Is that not as bad as it can get ? If a domain is allowed to do anything
> with all files on the  filesystem, it can craft a file with the right
> context which can then lead it to other domains (on execution). I

This is your scenario!  You presented me with a requirement and I suggested 
how you could solve it.  If the process does not need to create arbitrary 
files but instead needs to create files from a small list of types that are 
known in advance then modifying the policy to cope with it is easy.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
