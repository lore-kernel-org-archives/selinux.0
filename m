Message-ID: <418B9D6C.7080008@trustedcs.com>
Date: Fri, 05 Nov 2004 09:34:04 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Frank Mayer <mayerf@tresys.com>, "'Colin Walters'" <walters@verbum.org>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
References: <01df01c4c336$4facc6f0$1e0c010a@columbia.tresys.com>	 <418B968F.3070700@trustedcs.com> <1099668037.6373.126.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1099668037.6373.126.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2004-11-05 at 10:04, Darrel Goeddel wrote:
> 
>>The process first needs the ability to perform a dynamic transition ("allow 
>>foo_t self:process dyntransition").
> 
> 
> You mean "setcurrent", right?  dyntransition is the pairwise check, as
> you correctly described later in the same message.
> 

Yep, thats the one...

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
