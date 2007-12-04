Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB4HAHSk005571
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 12:10:17 -0500
Received: from web36605.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lB4HAGwr020463
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 17:10:16 GMT
Date: Tue, 4 Dec 2007 09:10:15 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Interface for DOI mapping
To: Paul Moore <paul.moore@hp.com>, Dave Quigley <dpquigl@tycho.nsa.gov>
Cc: Labeled NFS <labeled-nfs@linux-nfs.org>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200712031616.03019.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <254486.24688.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Paul Moore <paul.moore@hp.com> wrote:

> On Monday 03 December 2007 3:32:45 pm Dave Quigley wrote:
> >     With help from Neil I have the actual daemon code working for DOI
> > translations. Now I have to come up with an interface for allowing an
> > LSM to specify its translations. Either in the form of a separate
> > library or in the daemon code itself I intend to dlopen a shared library
> > and make calls into it. The question is what functionality do we want
> > here and where should it be placed.
> >
> > In the long run it would be nice to have a server which maintains the
> > mappings for all of the clients in its domain similar to kerberos.
> > However the client also needs to be able to operate without such a
> > server.
> >
> > If you have suggestions for this feel free to make them now while I am
> > still designing this.
> 
> The first question that immediately springs to mind is "which DOI?"  I know 
> you are currently focused on labeled NFS and how to translate file labels 
> between different MAC implementations but I think it is worthwhile to broaden
> 
> the scope of the DOI translation effort.  I know that both CIPSO and labeled 
> IPsec have DOI attributes and a proper DOI translation mechanism could have 
> benefits here too.  There are probably others (labeled X? labeled databases?)

I strongly encourage everyone to have a look at the Mitre CMW
label mapping scheme (I'm sure someone can dredge it up from
somewhere, I unfortunatly don't have it handy) and put it on the
table as a really bad option. In it's a attempts to be general
it demonstrates just how hard it is to do meaningful mappings
between DOIs.

What I do recomend is a table in the form:

    DOI1:value1:DOI2:value2

Where each entry is interpreted as a one way translation.
For example:

   801:juan:906:wendy

would say that if you're in DOI 906, and you're presented with
"juan" from DOI 801 you would use "wendy" locally. It does not
mean that if you know what to send back, if the mapping is
reflexive you would also need

   906:wendy:801:juan

Why? Consider an environment where MLS is in use on one
machine, but not another. You might want to map

   906:vampire_t:801:redcross_t
   906:werewolf_t:801:redcross_t

inbound but provide a different value on the way back
to reflect that fact that you don't know which it was coming in

  801:redcross_t:906:nocturnal_t

and let the far end deal with the details of making this work.

which brings up the question of who does the translation.
I suggest that the receiver always do the mapping and that the
sender always speaks it's native DOI. 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
