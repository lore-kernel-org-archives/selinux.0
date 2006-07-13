From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: setsebool
Date: Thu, 13 Jul 2006 08:25:02 -0400
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Michael C Thompson <thompsmc@us.ibm.com>,
        SE Linux <selinux@tycho.nsa.gov>
References: <44AD708E.10205@us.ibm.com> <44B6265C.3010005@redhat.com> <1152792460.10075.179.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1152792460.10075.179.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200607130825.02416.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 13 July 2006 08:07, Stephen Smalley wrote:
> We could likely drop the auditallow statement on setbool as it isn't
> particularly useful and we now have the explicit audit messages for
> MAC_CONFIG_CHANGE.

That would be great.

Thanks,
-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
