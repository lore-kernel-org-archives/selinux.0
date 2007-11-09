Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA9MJ9dT031155
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 17:19:09 -0500
Received: from web36614.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id lA9MJ7SU001701
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 22:19:07 GMT
Date: Fri, 9 Nov 2007 14:19:02 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC PATCH v6 05/13] SELinux: add secctx_to_secid() LSM hook
To: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <20071109212415.31738.16402.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <199039.66000.qm@web36614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Paul Moore <paul.moore@hp.com> wrote:

> Add a secctx_to_secid() LSM hook to go along with the existing
> secid_to_secctx() LSM hook.

I'll bite. Where does this get used?

There are already places in the networking and audit code where
a secid is gotten and saved for the sole purpose of getting a secctx
at some later time. My favorite example:

> static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
> {
>         char *secdata;
>         u32 seclen, secid;
>         int err;

In the Smack case what's in skb is the secctx.

>         err = security_socket_getpeersec_dgram(NULL, skb, &secid);
>         if (err)
>                 return;

Smack pulls the secctx off the packet and finds a secid for it.

>         err = security_secid_to_secctx(secid, &secdata, &seclen);
>         if (err)
>                 return;

Just so that it can turn around and look up the secctx it had in the
first place.

>         put_cmsg(msg, SOL_IP, SCM_SECURITY, seclen, secdata);
>         security_release_secctx(secdata, seclen);

Fortunatly, this is no-op.

> }

I expect that the purpose of the proposed secctx_to_secid() is to
make it easier to implement more of these cases, where the only
reason to do the conversion is to have something to convert back
later. With SELinux as the only consumer of the LSM, and with the
SELinux secid mindset I suppose this could make sense. It would
also be perfectly reasonable if there was anything to do with a
secid except convert it to a secctx, but there isn't.

There. I got the righteous indignation off my chest. I say to
go ahead with adding this to the LSM because I need it to for
dealing with the aformentioned audit code, which I have looked
into fixing to use secctx instead of secid, and determined that
there are a couple cases where you end up with the secid in any
case.

In Linux 2.7 I propose that we fix these problems. Not today.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
