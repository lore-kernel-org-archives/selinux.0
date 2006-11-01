Message-ID: <4548E7AB.7080404@hp.com>
Date: Wed, 01 Nov 2006 13:30:03 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: vyekkirala@TrustedCS.com, James Morris <jmorris@namei.org>,
        Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>, jbrindle@tresys.com,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com
Subject: Re: SELinux Networking Enhancements
References: <000c01c6fdce$8b49fcd0$cc0a010a@tcssec.com> <1162403736.4095.12.camel@sgc>
In-Reply-To: <1162403736.4095.12.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2006-11-01 at 09:58 -0600, Venkat Yekkirala wrote:
>
>>allow apache_t mozilla_t:association { recvfrom };
>>allow apache_t self:association { sendto };
>>
>>with the client having the following rules:
>>
>>allow mozilla_t apache_t:association { recvfrom };
>>allow mozilla_t self:association { sendto };
>  
> This doesn't cut it because you have no control who you are sending to.

Now, this would only work for connected stream sockets, but I imagine you could
always do an access check against the peer's context which you could obtain
using a process similar to getpeercon().

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
