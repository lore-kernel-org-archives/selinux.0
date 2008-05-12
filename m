From: Paul Moore <paul.moore@hp.com>
To: subrata@linux.vnet.ibm.com
Subject: Re: SELinux Policy test cases updates
Date: Mon, 12 May 2008 12:05:13 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        ltp-list <ltp-list@lists.sourceforge.net>,
        Jeff Burke <jburke@redhat.com>, "Serge E. Hallyn" <serue@us.ibm.com>
References: <1210604450.4754.62.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1210604450.4754.62.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805121205.13893.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 12 May 2008 11:00:50 am Subrata Modak wrote:
> Hi Stephen,
>
> Any new updates for the LTP reference policy support for SELinux
> recently available with you ?
>
> I found the following updates for SELinux in the new stable 2.6.25
> Kernel:
>
> * SELinux: Add network ingress and egress control permission checks,

The reference policy updates for the new network permissions are still 
unfinished, there is basic Flask policy support but that is about it.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
