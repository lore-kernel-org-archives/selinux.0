Subject: Re: problems using setcon()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kodungallur Varma <ramgwu@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <fa8ec5d805031118353197f745@mail.gmail.com>
References: <fa8ec5d80503082008161e5619@mail.gmail.com>
	 <20050309084655.GC5236@thorium.jmh.mhn.de>
	 <fa8ec5d805031118353197f745@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-YSeUOUBgVrI6HrUwLcW8"
Date: Mon, 14 Mar 2005 10:06:12 -0500
Message-Id: <1110812772.21378.79.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-YSeUOUBgVrI6HrUwLcW8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-03-11 at 21:35 -0500, Kodungallur Varma wrote:
>        I came to know that I cant simply cast a string into a security
> identifier as shown below. insted I found out that I have to use
> security_compute_create().

No, you can directly construct context strings; you just have to ensure
that they are valid contexts or the kernel will reject them.  The
easiest approach is to use getcon() to get the current context, then use
the context_new(), context_type_set(), context_str() functions to create
a context string with a modified type field, and then call setcon() on
the resulting context string.  security_compute_create() is appropriate
when you want to get a context based on a type_transition rule in the
policy (for an exec-based process transition or a file creation), but
that is not what you are doing.  Sample program below should work for
you, assuming appropriate policy and a kernel that supports dynamic
context transitions (>= 2.6.11 for the mainline kernel).  Policy would
need can_setcon() for the domain and allow <olddomain>
<newdomain>:process dyntransition; (the domain_auto_trans rules are for
exec-based transitions only).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

--=-YSeUOUBgVrI6HrUwLcW8
Content-Disposition: attachment; filename=setconexample.c
Content-Type: text/x-csrc; name=setconexample.c; charset=utf-8
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <selinux/selinux.h>
#include <selinux/context.h>

int main(int argc, char **argv)
{
	int rc;
	security_context_t scon;
	context_t con;

	if (argc != 2) {
		fprintf(stderr, "usage: %s newtype\n", argv[0]);
		exit(1);
	}

	rc = getcon(&scon);
	if (rc < 0) {
		perror("getcon");
		exit(1);
	}
	con = context_new(scon);
	freecon(scon);
	rc = context_type_set(con, argv[1]);
	if (rc) {
		perror("context_type_set");
		exit(1);
	}
	scon = context_str(con);
	if (!scon) {
		perror("context_str");
		exit(1);
	}
	if (security_check_context(scon) < 0) {
		fprintf(stderr, "%s is not a valid context in the policy\n",
			scon);
		exit(1);
	}
	rc = setcon(scon);
	if (rc < 0) {
		perror("setcon");
		exit(1);
	}
	context_free(con);
	scon = NULL;
	rc = getcon(&scon);
	if (rc < 0) {
		perror("getcon");
		exit(1);
	}
	printf("Changed to %s\n", scon);
	exit(0);
}

--=-YSeUOUBgVrI6HrUwLcW8--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
