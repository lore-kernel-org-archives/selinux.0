Message-ID: <7B2A7784F4B7F0409947481F3F3FEF8304ACC36A@eammlnt051.lmc.ericsson.se>
From: "Eric Gingras (LMC)" <Eric.Gingras@ericsson.ca>
To: "SELinux Mailing list (E-mail)" <SELinux@tycho.nsa.gov>
Subject: Another newbie question...
Date: Thu, 12 Sep 2002 16:52:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
First of all, thank you to M. Coker, M. Caplan and M. Smalley for their good
hints in answer to my previous question to the group.

Here's my problem this time :

I builded a small application (wrongly named HTTPServer) from the following
code:

	#include <stdio.h>
	#include <string.h>

	int main()
	{
		FILE *pFile;
	
		printf("Starting...\n");
		pFile = fopen ("fichier_test","rt");
  		if (pFile!=NULL)
  		{
    			printf("*** The fichier_test file has been accessed
***\n");
    			fclose (pFile);
  		}
		else printf("*** Unauthorized access to file fichier_test
***\n");
	
		while(1)
		{}

		return 0;
	}

You probably understand that a text file called "fichier_test" is present in
the same directory than the HTTPServer binary.

So I have 2 files: a binary called "HTTPServer" and a data file called
"fichier_test".  Contexts for those files are defined in
policy/file_context/program/HTTPServer.fc, which contains this:

	/home/telorb/eric/user/server/HTTPServer
system_u:object_r:HTTPServer_exec_t
	/home/telorb/eric/user/server/fichier_test
system_u:object_r:HTTPServer_data_t

I've check with "ls --context" and everything is fine...

Next, I tried to define a domain for the process created when executing the
binary (HTTPServer).  I did this in a file called  HTTPServer.te which is
located in policy/domains/program. Here's the content of HTTPServer.te:

	type HTTPServer_t, domain, privlog;
	role sysadm_r types HTTPServer_t;

	every_domain(HTTPServer_t)

	type HTTPServer_exec_t, file_type, sysadmfile, exec_type;
	type HTTPServer_data_t, file_type, sysadmfile;


	# Transition into this domain when you run this program.
	domain_auto_trans(sysadm_t, HTTPServer_exec_t, HTTPServer_t)

	allow HTTPServer_t HTTPServer_data_t:file r_file_perms;

I reloaded the policy and relabeled the entire filesystem.

When executing HTTPServer in permissive mode with the sysadm_r role or
user_r role(checked with "ps --context": with sysadm_r the process has the
HTTPServer_t type and with user_r it has the user_t type), both times I had
the following answer:

	Starting...
	*** The fichier_test file has been accessed ***

That's what I expected.

When executing HTTPServer in enforcing mode with the user_r role (process
has user_t type), I had the following answer:

	Starting...
	*** Unauthorized access to file fichier_test ***

Once again, that's what I expected.  But when executing with sysadm_r role
(I was expecting the same behaviour than when executed in permissive mode)
no answer.  The process is existing (checked with ps --context) it as the
desired type (HTTPServer_t) but not even "Starting..." (which is the result
of 1st instruction) appeared.  Is that a strange behaviour caused by a bug,
or did I missed something in the "HTTPServer.te"?

Any hints will be apreciated... and sorry for my poor english.

Thanks,

Eric Gingras
Eric.Gingras@ericsson.ca


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
