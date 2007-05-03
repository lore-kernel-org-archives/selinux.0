In-Reply-To: <1178025679.26421.40.camel@moss-spartans.epoch.ncsc.mil>
References: <637AC7CF-43ED-4078-BF5D-0A0604D3E314@sf-net.com> <1178025679.26421.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <032854E3-0523-4657-A53C-B4F6FB986CDF@sf-net.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: MLS and no read up, no write down
Date: Thu, 3 May 2007 14:31:38 +0200
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> MLS/BLP is a confidentiality model, not an integrity model.  It is
> usually used together with an integrity model such as Biba or Type
> Enforcement (TE).

Ok that sounds logical to me!

> Note btw that multi-level security can be implemented via Type
> Enforcement (just map levels to types and define your allow rules to
> match the BLP restrictions) if the discrete number of levels is not  
> too
> large, and real multi-level security needs are often met better by TE,
> as it supports controlled information flow via assured pipelines. Even
> if one needs the native MLS engine in SELinux (e.g. to support a huge
> number of discrete levels due to many categories), TE provides a  
> way to
> confine and protect MLS trusted subjects and to provide integrity and
> least privilege.  TE was originally designed to complement MLS in that
> manner.

That's right. In most situatiions I would use TE because it's not so  
complex
and therefor not so error-prone.

Thanks for the detailed explanations!

Best regards,
Stefan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
