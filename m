Message-ID: <466DD591.4030004@tycho.nsa.gov>
Date: Mon, 11 Jun 2007 19:06:57 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH 1/3] libselinux: labeling support (try 3)
References: <466DA23C.9080509@tycho.nsa.gov> <1181595322.6699.23.camel@localhost.localdomain>
In-Reply-To: <1181595322.6699.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's some test code that I've been using.  The program looks up
the command line argument as a file first, then as a media label.

The file options are set up with a "matchpathcon_prefix" of /etc and
validation turned on.

I can produce a patch for setfiles, but that will take a little
longer since all the inode code that was placed into libselinux has
to be put back into setfiles.


#include <stdio.h>
#include <stdlib.h>

#include <selinux/selinux.h>
#include <selinux/label.h>

static void test_file(const char *str)
{
	selabel_handle_t hnd;
	security_context_t result;
	int rc;
	struct selabel_opt opts[] = {
		{ SELABEL_OPT_PREFIX, "/etc" },
		{ SELABEL_OPT_VALIDATE, "1" }
	};

	hnd = selabel_open(SELABEL_CTX_FILE, opts, 2);
	if (!hnd) {
		perror("selabel_open");
		exit(1);
	}

	rc = selabel_lookup(hnd, &result, str, 0);
	if (rc < 0) {
		perror("selabel_lookup");
	} else {
		printf("File result is: %s\n", result);
		freecon(result);
	}
	
	selabel_close(hnd);
}

static void test_media(const char *str)
{
	selabel_handle_t hnd;
	security_context_t result;
	int rc;

	hnd = selabel_open(SELABEL_CTX_MEDIA, NULL, 0);
	if (!hnd) {
		perror("selabel_open");
		exit(1);
	}

	rc = selabel_lookup(hnd, &result, str, 0);
	if (rc < 0) {
		perror("selabel_lookup");
	} else {
		printf("Media result is: %s\n", result);
		freecon(result);
	}
	
	selabel_close(hnd);
}

int main(int argc, char **argv)
{
	if (argc != 2) {
		fprintf(stderr, "usage\n");
		return 1;
	}
		
	test_file(argv[1]);
	test_media(argv[1]);

	return 0;
}




-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
