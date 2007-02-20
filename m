Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KGuCii001542
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 11:56:13 -0500
Received: from web51509.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1KGvTlw008499
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 16:57:29 GMT
Message-ID: <20070220165727.62975.qmail@web51509.mail.yahoo.com>
Date: Tue, 20 Feb 2007 08:57:27 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: restorecond matchpathcon patch
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Athey <jathey@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1171987328.14363.98.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> IOW, this patch cleans up one problem, but I wonder if the underlying
>> algorithm should be changed to be less of a memory hog.
>
>Possibly the FCGlob work will help address that problem.

Is that restorecond work or libselinux work? The change in algorithm I was
thinking about was in restorecond. IOW, it could cache the correct context for
the handful of files it cares about and use matchpathcon only for the paths that
contain metacharacters. It could monitor for policy reloads and correct its cache
in that event. For what its doing, it consumes a lot of memory as is.

>Calling matchpathcon_fini each time will require re-creation of the
>entire in-memory table from the file contexts configuration on each
>matchpathcon call, so you are trading off runtime performance for memory
>here.

If you want to leave it alone, we should have something like this added to
restorecond.c:

@@ -483,6 +483,7 @@ int main(int argc, char **argv)

        watch_list_free(master_fd);
        close(master_fd);
+       matchpathcon_fini();
        if (pidfile)
                unlink(pidfile);

so that valgrind can spot real memory leaks. Besides matchpathcon, valgrind is
reporting other memory issues.

-Steve


 
____________________________________________________________________________________
Any questions? Get answers on any topic at www.Answers.yahoo.com.  Try it now.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
