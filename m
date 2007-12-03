From: Paul Moore <paul.moore@hp.com>
To: Dave Quigley <dpquigl@tycho.nsa.gov>
Subject: Re: Interface for DOI mapping
Date: Mon, 3 Dec 2007 16:16:02 -0500
Cc: Labeled NFS <labeled-nfs@linux-nfs.org>, SE Linux <selinux@tycho.nsa.gov>
References: <1196713965.31856.19.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1196713965.31856.19.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712031616.03019.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 03 December 2007 3:32:45 pm Dave Quigley wrote:
>     With help from Neil I have the actual daemon code working for DOI
> translations. Now I have to come up with an interface for allowing an
> LSM to specify its translations. Either in the form of a separate
> library or in the daemon code itself I intend to dlopen a shared library
> and make calls into it. The question is what functionality do we want
> here and where should it be placed.
>
> In the long run it would be nice to have a server which maintains the
> mappings for all of the clients in its domain similar to kerberos.
> However the client also needs to be able to operate without such a
> server.
>
> If you have suggestions for this feel free to make them now while I am
> still designing this.

The first question that immediately springs to mind is "which DOI?"  I know 
you are currently focused on labeled NFS and how to translate file labels 
between different MAC implementations but I think it is worthwhile to broaden 
the scope of the DOI translation effort.  I know that both CIPSO and labeled 
IPsec have DOI attributes and a proper DOI translation mechanism could have 
benefits here too.  There are probably others (labeled X? labeled databases?) 
but I'm not knowledgeable enough in those areas to say for certain.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
