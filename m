Date: Fri, 14 Jan 2005 00:17:49 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux@tycho.nsa.gov
Subject: Re: Multiple contexts
Message-Id: <20050113231748.GA4999@jmh.mhn.de>
References: <1105390249.8093.21.camel@cobra.ivg2.net> <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil> <1105560687.11135.26.camel@cobra.ivg2.net> <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil> <1105571319.11828.19.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
In-Reply-To: <1105571319.11828.19.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Fba/0zbH8Xs+Fj9o
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Ivan Gyurdiev <ivg2@cornell.edu> [2005-01-13 01:14]:
> What about a tool that creates a hybrid type on demand, and stores that
> information in the policy?
>=20
> createcon samba_httpd_content_t --inherit=20
> 	samba_share_t httpd_sys_content_t
> chcon -R samba_httpd_content_t ~/webserver

This seems very useful. I have experimented a bit with this idea this
evening; the resulting script is attached. It takes a policy.conf and
outputs a new type (plus corresponding rules).
The script is not perfect because it parses the policy.conf itself, but
it should work for almost all file_types.

You will still need policy sources, but you won't need to go through
all sources to find the appropriate rules, the following should do the
trick (not tested):

# cd /etc/selinux/strict/src/policy
# make policy.conf
# createcon samba_httpd_content_t samba_share_t httpd_sys_content_t < polic=
y.conf >> domains/misc/local.te
# make reload

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=createcon
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl -w
#
# this script creates a new SELinux type which is the union of two types
# (C) 2005 by Thomas Bleher under the GNU GPL
#
# Please note that this is just proof of concept code; it has some limitati=
ons:
# * assumes every statement is one line
# * does not really handle "{ domain - foo_t }"
# * does not always handle ~ correctly; this shouldn't be a problem with cu=
rrent policy
# * does not handle type_change and type_transition (not sure if there even=
 is a correct way)
# * only works on file_type (domains would need role type statements and ar=
e more difficult=20
#   because of domain_auto_trans())
# * neverallow and constraints are not properly handled
# * might generate duplicate permissions (these are not harmful)
#
# despite this, it should work most of the time

if (@ARGV < 3) {
	print STDERR "Usage: createcon [NewType] [OldType1] [OldType2]\n";
	print STDERR "policy info (policy.conf) is read from standard in\n";
	print STDERR "Example: createcon samba_httpd_content_t samba_share_t httpd=
_sys_content_t < policy.conf\n";
	exit(1);
}

# get command line arguments
my ($new_type, $type1, $type2) =3D splice(@ARGV, 0, 3);


# parse the policy

$pat =3D '(\w+|~?{[^}]+}|\*)\s*'; # $pat matches on foo_t or { foo_t bar_t =
} or *

while (<>) {
	# remove everything we do not need
	s/#.*?$//mg; # comments
	s/^\s*$//mg; # empty lines
	next if /^[\s\n]*$/;

	# remove duplicate braces (we have to loop until all are gone)
	# this is for things like "{ read{getattr {write setattr }}}"
	for ( ;s/{([^}]*){([^}]*)}/{$1 $2/g; ) {}

	if (/if \s* \( ([^\)]+) \)/x) { # save all active bools in a stack
		push @bools, $1;

	} elsif (/(allow|dontaudit|auditallow|auditdeny) \s+ $pat \s+ $pat : \s* $=
pat \s+ $pat;/x) { # normal rules
		my $bool =3D join ') && (', @bools;
		push @{$rules{$1}}, [$2,$3,$4,$5,$bool];

	} elsif (/type\s+([^;]+);/) {
		my @tmp =3D split /,\s+/, $1; # get attributes
		my $type =3D shift @tmp;
		$types{$type} =3D [@tmp];

	} elsif (/typeattribute\s+(\w+)\s+(\w+)/) {
		push @{$types{$1}}, $2;

	} elsif (/\}/) { # this rule has to be the last so we don't grab braces fr=
om an allow rule
		pop @bools;
	}
}

# create a new type which is the union of the old types
my (%tmp);
for (@{$types{$type1}}) {
	$tmp{$_}++;
}
for (@{$types{$type2}}) {
	$tmp{$_}++;
}
print "type $new_type, ", join(", ", keys %tmp), ";\n";


# now create the rules

for $ruletype (keys %rules) {
	for (@{$rules{$ruletype}}) { # traverse all the rules

		if ($_->[0] =3D~ /$type1|$type2/) { # not sure if this is correct; what h=
appens if a type is twice in a rule?
			$_->[0] =3D $new_type; # replace source

		} elsif ($_->[1] =3D~ /$type1|$type2/) {
			$_->[1] =3D $new_type; # replace target

		} else { # ignore all other rules
			next;
		}

		# now print it
		if ($_->[4] ne '') { # any bools active?
			print "if ($_->[4]) {\n";
			print "$ruletype $_->[0] $_->[1]:$_->[2] $_->[3];\n";
			print "}\n";
		} else {
			print "$ruletype $_->[0] $_->[1]:$_->[2] $_->[3];\n";
		}
	}
}

__END__

# not used currently, but nice for debugging:

# print all the stuff we have extracted
for (keys %types) {
	print "type $_, ", join(", ", @{$types{$_}}), ";\n";
}
for $ruletype (keys %rules) {
	for (@{$rules{$ruletype}}) {
		if ($_->[4] ne '') {
			print "if ($_->[4]) {\n$ruletype $_->[0] $_->[1]:$_->[2] $_->[3];\n}\n";
		} else {
			print "$ruletype $_->[0] $_->[1]:$_->[2] $_->[3];\n";
		}
	}
}

--wac7ysb48OaltWcw--

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5wGcxWIrrrL0q+cRAt9jAJwM837TGr9F2oBTHZx5NVd5JxhIsgCfSyYO
zsewBCPPQk67Ma9FTbd8S3o=
=RLeq
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
