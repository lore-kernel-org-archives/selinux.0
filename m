Subject: Re: Custom domains
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "James R. Kratzer" <JamesK@xetron.com>
Cc: "SELinux (E-mail)" <SELinux@tycho.nsa.gov>
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A52@s3cin>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A52@s3cin>
Content-Type: text/plain
Message-Id: <1065811282.8181.514.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 10 Oct 2003 14:41:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-10 at 14:23, Kratzer, James R. wrote:
> I want to have multiple instances of a program running with each instance
> running in its own custom domain.  Is this possible with SELinux and are
> their any examples of this in the example policy?  

You can automatically transition a program into a domain based on the
calling domain and the entrypoint type via the domain_auto_trans macro.
However, for a given calling domain and entrypoint type, you can only
specify a single new domain.  You can also permit explicit transitions
(e.g. via the runcon utility) via the domain_trans macro, and then use
runcon to place each instance in the domain you desire.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
