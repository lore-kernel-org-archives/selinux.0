From: Paul Moore <paul.moore@hp.com>
To: casey@schaufler-ca.com
Subject: Re: [PATCH 4/7] Security: Add secctx_to_secid LSM hooks and security helper functions
Date: Wed, 1 Aug 2007 17:41:18 -0400
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
References: <666641.25795.qm@web36612.mail.mud.yahoo.com>
In-Reply-To: <666641.25795.qm@web36612.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708011741.19107.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, August 1 2007 5:11:27 pm Casey Schaufler wrote:
> --- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:
> > From: David P. Quigley <dpquigl@tycho.nsa.gov>
> >
> > The existing LSM interface provides a hook for converting a security
> > identifier
> > to a security context. This patch introduces a complementary hook to
> > provide the conversion from the security context to corresponding
> > security identifier.
>
> This is strictly SELinux behavior. I don't suppose it hurts
> anything, but a general framework won't need this.

I'm not so sure about that ... having a mechanism which maps an arbitrarily 
large label into a easily manipulated token (and back again) seems like 
something that could be of use to other security mechanisms besides 
SELinux/TE.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
