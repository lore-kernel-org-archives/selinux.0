MIME-Version: 1.0
In-Reply-To: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil>
References: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil>
Date: Fri, 10 Apr 2009 13:09:59 +0000
Message-ID: <cadfc0e40904100609n7f1927e4kba43ebb1201284ff@mail.gmail.com>
Subject: Re: Policy infrastructure problems and improvement
From: Xavier Toth <txtoth@gmail.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 9, 2009 at 3:28 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:
> I am looking at improving the policy infrastructure.  The ultimate goal
> is to make SELinux policy writing, policy customization, policy
> management, and administration easier and less confusing. My focus will
> be on the userspace parts of SELinux.
>
> My plan to do this is as follows:
> (1) Determine and enumerate the existing problems of the current
> infrastructure.
> (2) Determine the desired capabilities and architecture of the ideal
> infrastructure.
> (3) Determine the changes needed to the current architecture to fix the
> current problems and to provide the desired capabilities.
> (4) Make the policy infrastructure as close to the ideal as possible
> while providing some kind of backwards compatibility and taking other
> practicalities into consideration.
>
> I have had some informal discussions with others internally and at
> Tresys, and the five emails to follow have my summary of the problems
> that have been identified in those discussions.
>
> My hope is that there will be a good discussion and that others on the
> list will identify other problems and provide more details or examples
> to the problems already identified.
>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

We need a policy debugger.

Ted


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
