Subject: Re: sepol_genusers
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1108734223.28149.13.camel@moss-spartans.epoch.ncsc.mil>
References: <1108656216.24494.65.camel@moss-spartans.epoch.ncsc.mil>
	 <42152EAB.8090600@redhat.com>
	 <1108734223.28149.13.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 09:28:16 -0500
Message-Id: <1108736896.29253.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-18 at 08:43 -0500, Stephen Smalley wrote:
> Possibly we could change /sbin/init and load_policy to just load the
> original binary policy image in the case where sepol_genusers(3) returns
> an error, as it doesn't modify that image during processing - it just
> creates a new image.

The patch below would make this change for load_policy, so that it will
just fall through to loading the original binary policy image if
sepol_genusers(3) returns an error.

Index: policycoreutils/load_policy/load_policy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/load_policy/load_policy.c,v
retrieving revision 1.11
diff -u -p -r1.11 load_policy.c
--- policycoreutils/load_policy/load_policy.c	17 Feb 2005 15:25:01 -0000	1.11
+++ policycoreutils/load_policy/load_policy.c	18 Feb 2005 14:22:01 -0000
@@ -87,7 +87,8 @@ int main(int argc, char **argv) 
 	ret = sepol_genusers(map, sb.st_size, selinux_users_path(), &data, &data_size);
 	if (ret < 0) {
 		fprintf(stderr, _("%s:  Error while setting user configuration from %s:  %s\n"), argv[0], selinux_users_path(), strerror(errno));
-		exit(2);
+		data = map;
+		data_size = sb.st_size;
 	}
 
 	if (setbools) {

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
