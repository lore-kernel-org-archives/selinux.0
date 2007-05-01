Message-ID: <46373DE2.7050801@manicmethod.com>
Date: Tue, 01 May 2007 09:17:22 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: MLS and no read up, no write down
References: <637AC7CF-43ED-4078-BF5D-0A0604D3E314@sf-net.com>
In-Reply-To: <637AC7CF-43ED-4078-BF5D-0A0604D3E314@sf-net.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stefan Schulze Frielinghaus wrote:
> Hello,
>
> in D. Bell and L. LaPadula "Secure Computer System: Unified Exposition 
> and Multics Interpretation" on page 42 the feature to append something 
> to a file is described as:
>
> if attribute is append, current-level(subject) is dominated by 
> level(object);
>
> Wouldn't this mean that someone with a security level e.g. of 
> unclassified could append something to a file labeled as top secret? 
> Isn't this a security problem? For example someone can't read a top 
> secret file but he could append rubbish or false information.
>
> M. Bishop "Computer Security: Art and Science" describes the Bell 
> LaPadula model on page 125 even for write acces:
>
> S can write O if and only if l(s) <= l(o) and S has discretionary 
> write access to O.
>
> Is the SELinux MLS stuff exactly build like the Bell LaPadule theory? 
> The "no read up" theory sounds good and logical but the "no write 
> down" sounds suspicious. I would expect that if I write to a file that 
> the current level of the subject has to be equal to the level of the 
> object.
>
> How is something like that handled by SELinux?
BLP is only concerned with information flow of confidential data, that 
is all. No read up, no write down are the rules that enforce the policy 
model they are concerned with. Writing up and reading down will not 
cause information flow of confidential materials to lower classification 
levels and therefore is not a violation of the policy (hence it is 
allowed).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
