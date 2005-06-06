Message-Id: <200506060148.j561mRLu020682@turing-police.cc.vt.edu>
To: Arpan Darivemula <apd005@latech.edu>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: fork rules 
In-Reply-To: Your message of "Sun, 05 Jun 2005 15:13:38 CDT."
             <1118002418.21085.10.camel@Raikiri.metadns.cx>
From: Valdis.Kletnieks@vt.edu
References: <1118002418.21085.10.camel@Raikiri.metadns.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118022506_4209P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 05 Jun 2005 21:48:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1118022506_4209P
Content-Type: text/plain; charset=us-ascii

On Sun, 05 Jun 2005 15:13:38 CDT, Arpan Darivemula said:

> int main( int argc, char **argv )
> {
>         int pid;
> 
>         pid = getpid();
>         printf( "Parent PID: %i\n", pid );
> 
>         if ( fork() == 0 )
>         {
>                 pid = getpid();
>                 printf( "Child PID: %i\n", pid );
>         }
> }

I'd stick a 'sleep(120);' in there just before the fork() call, and then
start using 'pa axZ' or similar to find out what you're actually running as.

> neverallow dsifork_exec_t self:process{fork};

You're probably not actually in dsifork_exec_t. Probably because:

> allow user_t dsifork_exec_t:file {execute execute_no_trans read};

Did you really want execute_*NO*_trans there?  That means that a user_t
can exec a dsifork_exec_t and *remain* a user_t.  I think you wanted something
like:

domain_auto_trans(user_t, dsi_fork_t, dsi_fork_exec_t);
neverallow dsi_fork_t self:process(fork);

and then label the file as dsi_fork_exec_t, and apply the restriction to
dsi_fork_t


--==_Exmh_1118022506_4209P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCo6tqcC3lWbTT17ARApMIAKDOwj+JKFfptZosvqkJ7Htg9S3f6ACfS4cR
1ZtlJ1y6272IGJYP+cNzY44=
=iYkc
-----END PGP SIGNATURE-----

--==_Exmh_1118022506_4209P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
