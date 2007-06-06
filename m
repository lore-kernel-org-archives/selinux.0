From: Paul Moore <paul.moore@hp.com>
To: vyekkirala@TrustedCS.com
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an interface)
Date: Wed, 6 Jun 2007 09:47:56 -0400
Cc: "KaiGai Kohei" <kaigai@ak.jp.nec.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "KaiGai Kohei" <kaigai@kaigai.gr.jp>, "Joe Nall" <joe@nall.com>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>, ewalsh@tycho.nsa.gov
References: <000301c7a83f$ecf25920$cc0a010a@tcssec.com>
In-Reply-To: <000301c7a83f$ecf25920$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706060947.57384.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, June 6 2007 9:38:10 am Venkat Yekkirala wrote:
> > Your proposal is slightly different in that I view it more as
> > a per-domain
> > renaming scheme where you rename/relabel packets based on the
> > receiving
> > domain.  Can you help me understand the advantage of
> > renaming "untrusted_network_t" to "sepgsql_client_t" from a
> > policy point of
> > view?  For example, how would these two policy rules be
> > different or have any
> > advantage over one another:
> >
> >  allow sepgsql_t untrusted_network_t:<class> <perms>;
> >  allow sepgsql_t sepgsql_client_t:<class> <perms>:
>
> I doubt that the intent here is to change the permission checks
> to use the transition label. Rather the idea seems to be to
> have getpeercon() return the transition label (sepgsql_client_t).

My gut feeling is that getpeercon() should return the same context that we use 
for permission checks.  If getpeercon() returns something different I fear it 
could start to get very confusing from a user's/policy-writer's point of 
view.  Then again, maybe it's just me.

Perhaps Chris, Dan, and Stephen have some thought on this ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
