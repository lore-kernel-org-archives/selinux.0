Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5HKtJpG015589
 for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2016 16:55:19 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.80)
 (envelope-from <linseonn.20.mddlr@spamgourmet.com>)
 id 1bE0nM-0004W2-W8
 for selinux@tycho.nsa.gov; Fri, 17 Jun 2016 20:55:17 +0000
MIME-Version: 1.0
From: linseonn.20.mddlr@spamgourmet.com
Date: Fri, 17 Jun 2016 21:54:55 +0100
Message-ID: <CAADqsPgoRt8We_qNd26PO5QjjKsnfeXHfZ=BnYKZm7oD=E713A@mail.gmail.com>
Subject: sandbox - trying to use it / some bugs
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There is a tool - sandbox - in policycoreutils.   I wanted to use it
to provide a way to more safely possibly hostile files sent from
semi-"trusted" people.  E.g.

   sandbox -X -i ~/myfile1.doc libreoffice  ~/myfile1.doc

Doing this I came across a couple of problems and would like some
advice / help with fixes

The first thing is that, for files that are in the user's home
directory and have normal user contexts (e.g. on default Fedora 23
install unconfined_u:object_r:user_home_t) the program in the sandbox
simply fails to access the file.

  Full bug report:

   https://github.com/SELinuxProject/selinux/issues/16
probably also
   https://bugzilla.redhat.com//show_bug.cgi?id=1317046


As I started debugging,  the second thing is that it appears that the
intention of the different sandbox types doesn't match the
documentation which is confusing.

  https://github.com/SELinuxProject/selinux/issues/17

so I propose a patch for it

   https://github.com/SELinuxProject/selinux/pull/18


Please can someone look at these and comment back.

 - Is the doc fix correct? if so, could someone please accept it
 - is the correct thing for sandbox to do to change the context as it
copies files into the sandbox?
 - is there some more reliable / better already existing alternative to sandbox?

Thanks in advance for any help anyone can give

  Michael
