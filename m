Message-Id: <200411261858.iAQIwrrK013231@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Russell Coker <russell@coker.com.au>,
   Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions 
In-Reply-To: Your message of "Thu, 25 Nov 2004 21:35:19 GMT."
             <20041125213519.GD26737@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <4182959B.4080503@trustedcs.com> <1099402984.31739.17.camel@moss-spartans.epoch.ncsc.mil> <1099404989.23756.79.camel@pham.columbia.tresys.com> <200411260649.01922.russell@coker.com.au>
            <20041125213519.GD26737@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1445723607P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 26 Nov 2004 13:58:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1445723607P
Content-Type: text/plain; charset=us-ascii

On Thu, 25 Nov 2004 21:35:19 GMT, Luke Kenneth Casson Leighton said:
> On Fri, Nov 26, 2004 at 06:48:57AM +1100, Russell Coker wrote:
> 
> > If a running process has been cracked and does not have the same PID as the
> > original copy then the stop script will not stop it.

Of course, if the PID has changed, that means that the exploit did a fork/exec
as fork() is the only way I've ever seen an exploit acquire a new PID (sure,
you *could* write one that used clone(), but I've never actually seen one.. )

And when it hits the exec() call, the usual selinux checking will happen..

(Also, if the exploit did a fork/exec, then either the parent process is still
around and can be killed by the script, or the exploit trashed its stack and it
died a horrid death and isn't around to be killed anymore..)

>  i don't know if it's worthwhile but has anyone given serious
>  consideration to adding the pid into the selinux mix as a
>  permission to check operations against? (requiring that a pid
>  somehow be stored at runtime in the selinux policy of course).

I don't think your own PID is of any use here.  There *might* be reasons
to look at the parent PID or the process group leader PID, if you're trying
to restrict who can send signals etc..  But that would require some thinking,
because it's simple to restrict signals/pipes/whatever to other processes in
the same domain, while a "this process tree/group only" restriction implies there
are processes in the domain we don't want to talk to.  At that point, one must
wonder why they're in the same domain....

--==_Exmh_-1445723607P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBp3zrcC3lWbTT17ARAsAaAJ9YxnGerAos6PduVRdz/Wm6anwOLQCg7F/D
vVQyd0XfRQO4RzLO2hn4+Xs=
=eSnw
-----END PGP SIGNATURE-----

--==_Exmh_-1445723607P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
