Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7OCaZRm030221
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 08:36:45 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7OCa0kb016697
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 12:36:00 GMT
Message-ID: <4A928943.3040609@redhat.com>
Date: Mon, 24 Aug 2009 08:36:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux@tycho.nsa.gov, 503252-forwarded@bugs.debian.org
Subject: Re: policycoreutils: audit2allow -l doesn't work with dmesg pipe
References: <87d46mvb33.fsf@anzu.internal.golden-gryphon.com> <4A91803C.8030909@redhat.com> <200908240611.58935.russell@coker.com.au>
In-Reply-To: <200908240611.58935.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/23/2009 04:11 PM, Russell Coker wrote:
> On Mon, 24 Aug 2009, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=503252
>>
>> audit2allow -l is looking for the load_policy message which does not go to
>> the dmesg, /var/log/messages.  Therefore the tool has no idea when policy
>> was last loaded.
> 
> That would be a kernel bug then.
> 
Well I believe the messages that are intercepted by the audit.log do not go into dmesg, by design. 
Although Steve, James or Eric could probably say for sure.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
