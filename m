Message-ID: <52B84CDF.7020508@redhat.com>
Date: Mon, 23 Dec 2013 09:46:55 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Nicolas Iooss <nicolas.iooss@m4x.org>, Frank C <frankc@networkcrypt.com>,
 Selinux@tycho.nsa.gov
Subject: Re: Bug in libselinux/src/setrans_client.c
References: <CAJfZ7=myQGgMdJ3NWZHUPvSTpOA-mfJUFLGQLvVdCz7a3N5evQ@mail.gmail.com>
 <CAPJdAQBu3=ZyEqUqn_eq4HagfGZZP3-9u_Taimozkkt4EjGfZg@mail.gmail.com>
 <CAJfZ7=m0BoejRQsbTU+5+YLyid8tb1r9tTzeQSR7ZJS1ZmkFsQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=m0BoejRQsbTU+5+YLyid8tb1r9tTzeQSR7ZJS1ZmkFsQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/21/2013 09:27 AM, Nicolas Iooss wrote:
> My first message was not so clear. The check in 
> libselinux/src/lsetfilecon.c line 35 [1] doesn't work because 
> selinux_trans_to_raw_context(context, &rcontext) returns 0 and sets 
> rcontext to NULL. This is why I'm asking to change the return value to 
> something else if you want "cp -a" working. This fix is not to introduce a
> new feature but to fix an existing one.
> 
> Nicolas
> 

How about if we add a check on lsetfilecon_raw?  Changing the behaviour on
selinux_trans_to_raw_context might cause other problems.


diff --git a/libselinux/src/lsetfilecon.c b/libselinux/src/lsetfilecon.c
index 461e3f7..af3775e 100644
- --- a/libselinux/src/lsetfilecon.c
+++ b/libselinux/src/lsetfilecon.c
@@ -9,6 +9,10 @@

 int lsetfilecon_raw(const char *path, const security_context_t context)
 {
+       if (! context) {
+               errno=EINVAL;
+               return -1;
+       }
        return lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1
                         0);
 }

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlK4TN8ACgkQrlYvE4MpobNstACfcVXS9KZVDW9gc7PQrG7xUgVs
foIAoOe8r4LO0CoyzwGW3+TWsX2oaRKq
=BgSq
-----END PGP SIGNATURE-----
