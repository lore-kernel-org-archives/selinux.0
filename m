Subject: Re: Multiple contexts
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20050113231748.GA4999@jmh.mhn.de>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
	 <1105560687.11135.26.camel@cobra.ivg2.net>
	 <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil>
	 <1105571319.11828.19.camel@cobra.ivg2.net>
	 <20050113231748.GA4999@jmh.mhn.de>
Content-Type: multipart/mixed; boundary="=-gkSk3VWaH4c3OG/KbM4V"
Date: Fri, 14 Jan 2005 00:07:56 -0700
Message-Id: <1105686476.6472.5.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-gkSk3VWaH4c3OG/KbM4V
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> This seems very useful. I have experimented a bit with this idea this
> evening; the resulting script is attached. It takes a policy.conf and
> outputs a new type (plus corresponding rules).
> The script is not perfect because it parses the policy.conf itself, but
> it should work for almost all file_types.

Modified to work for N>=2 parent types, and fixes a bug in regexp to
match exact type, not any string containing it.

Disclaimer: I don't know a thing about perl.

... However, yes, I think it would be useful to have some sort of script
to do this kind of thing as part of the selinux tools. I shouldn't have
to tell it where to read from and write to.




-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-gkSk3VWaH4c3OG/KbM4V
Content-Disposition: attachment; filename=createcon
Content-Type: application/x-perl; name=createcon
Content-Transfer-Encoding: 7bit

#!/usr/bin/perl -w
#
# this script creates a new SELinux type which is the union of several old types
# (C) 2005 by Thomas Bleher under the GNU GPL
#
# Please note that this is just proof of concept code; it has some limitations:
# * assumes every statement is one line
# * does not really handle "{ domain - foo_t }"
# * does not always handle ~ correctly; this shouldn't be a problem with current policy
# * does not handle type_change and type_transition (not sure if there even is a correct way)
# * only works on file_type (domains would need role type statements and are more difficult 
#   because of domain_auto_trans())
# * neverallow and constraints are not properly handled
# * might generate duplicate permissions (these are not harmful)
#
# despite this, it should work most of the time

if (@ARGV < 3) {
	print STDERR "Usage: createcon [NewType] [Type1] [Type2] [Type3] ...\n";
	print STDERR "policy info (policy.conf) is read from standard in\n";
	print STDERR "Example: createcon samba_httpd_content_t samba_share_t httpd_sys_content_t < policy.conf\n";
	exit(1);
}

# get command line arguments


my ($new_type) = shift(@ARGV);
my (@parent_types) = splice(@ARGV, 0, $#ARGV+1);

# parse the policy

$pat = '(\w+|~?{[^}]+}|\*)\s*'; # $pat matches on foo_t or { foo_t bar_t } or *

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

	} elsif (/(allow|dontaudit|auditallow|auditdeny) \s+ $pat \s+ $pat : \s* $pat \s+ $pat;/x) { # normal rules
		my $bool = join ') && (', @bools;
		push @{$rules{$1}}, [$2,$3,$4,$5,$bool];

	} elsif (/type\s+([^;]+);/) {
		my @tmp = split /,\s+/, $1; # get attributes
		my $type = shift @tmp;
		$types{$type} = [@tmp];

	} elsif (/typeattribute\s+(\w+)\s+(\w+)/) {
		push @{$types{$1}}, $2;

	} elsif (/\}/) { # this rule has to be the last so we don't grab braces from an allow rule
		pop @bools;
	}
}

# create a new type which is the union of the old types
my (%tmp);
for (@parent_types) {
	for (@{$types{$_}}) {
		$tmp{$_}++;
	}
}
print "type $new_type, ", join(", ", keys %tmp), ";\n";


# now create the rules

for $ruletype (keys %rules) {
	for (@{$rules{$ruletype}}) { # traverse all the rules
		my ($types_expr) = join("|", @parent_types);

		if ($_->[0] =~ /^($types_expr)$/) { 
			# not sure if this is correct; what happens if a type is twice in a rule?
			$_->[0] = $new_type; # replace source

		} elsif ($_->[1] =~ /^($types_expr)$/) {
			$_->[1] = $new_type; # replace target

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

--=-gkSk3VWaH4c3OG/KbM4V--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
