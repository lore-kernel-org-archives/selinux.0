Content-Type: text/plain;
  charset="iso-8859-1"
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Russell Coker <russell@coker.com.au>
Subject: Re: Domain transition -- enabling user_r in eklogin
Date: Fri, 20 Dec 2002 14:07:42 -0600
Cc: SELinux@tycho.nsa.gov
References: <200212171725.MAA01304@moss-shockers.ncsc.mil> <200212201025.34107.pollard@admin.navo.hpc.mil> <200212201940.32007.russell@coker.com.au>
In-Reply-To: <200212201940.32007.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200212201407.42467.pollard@admin.navo.hpc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 20 December 2002 12:40 pm, Russell Coker wrote:
> On Fri, 20 Dec 2002 17:25, Jesse Pollard wrote:>
> > > The problem is that if you can run GPG currently you can encrypt the
> > > secret key to yourself with a password (IE not encrypting to a public
> > > key) and then decrypt the result to get the key.  A future version of
> > > GPG will address this.  I don't know how PGP performs in this regard.
> >
> > Yup. That is one of the things the application must be able to evaluate.
> > The output media/medium is the determining factor here. To do this
> > requires reading data with a high level label by a trusted process which
> > must NOT write that data to a media/medum with a low level label. That
> > trusted process SHOULD be able to read low labeled data, munch it using
> > high labled data, and write it to a low labeled media/medum since this is
> > WHY it is a trusted process.
>
> Are you sure that it's a good idea to make gpg a trusted program that can
> over-ride MLS boundaries rather than have it merely be trusted to perform
> the actions that the user requests of it?

Not all boundaries - only the one protecting the gpg secret key. You have to 
trust some program somewhere, and this one would seem to be the minimum.

> Currently we only have to trust that gpg will do what we tell it to.  The
> GPG developers plan to make some small changes to make it easier for me to
> ensure that gpg isn't executed in the wrong way by the wrong program.
>
> If gpg has to become a trusted part of system security (as it is on default
> Linux systems due to being SUID root) then the requirements on gpg are much
> greater.  The counter arguement of course is that this level of trust in
> gpg apparently works OK on default Linux setups...

And the one I suggested provides less trust than setuid.

The only modifications I can think of are that it would NOT allow the key to
be extracted IF it is providing output for a lower security level. I think it
would be desirable to allow it to USE the key (for encryption, decrypton, and
signing), but not allow the key itself to get out of the application, nor
allow the key to be replaced.

> > Personally, I dislike the idea of privileged applications. For a secure
> > environment, I would prever all secret keys to be maintained by a
> > security server process, and all queries/updates for access to this data
> > to be carried out by that security server. This would turn at least half
> > of GPG/Kerberos functions over to the security server (which should pass
> > the actions on the keys to sub processes. That includes
> > encryption/decryption services, though the security server may just pass
> > a socket connection back to the requesting application to allow that
> > application to push data into the encryption engine and either recieve
> > the results, or the output could already be connected to another socket
> > for outgoing data.
> >
> > Complicated perhaps, but no trusted application need exist other than the
> > security server. And the users would have no need to access the secret
> > keys directly.
>
> Interesting idea.  Sounds like kerberos on steroids.  ;)

yes - My original idea was to allow IPSec to handle the encryption, and the 
security server handle the keys, identfication, authentication, and initial
security labels. It makes most of the Kerberos utilities devolve into user 
interface, file/shell interface, and security server interaction. A much
simpler security environment when compaired to the amount of code
currently used in Kerberos.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
