Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9SMP2fT004022
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 18:25:02 -0400
To: selinux@tycho.nsa.gov
From: Dan <dtdevore64@yahoo.com>
Subject: Macro help
Message-ID: <56314B29.7020007@yahoo.com>
Date: Wed, 28 Oct 2015 18:24:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello everyone I have hit another bump with the cil macros. I am trying
to make a macro that covers the domain_type and domain_type_entry file
interfaces equivalent in Cil with macros that will confine a simple
shell script( and if anyone has any input to what I can do better or if
I am going about this in the wrong way please say so), but it says it
doesn't understand my "call usersubject_domain_type" line and won't
build for some reason. Here is what I have so far. Any help is much
appreciated, thanks.


(macro usersubject_domain_type ((type ARG1)) (type ARG2))
        (typeattributeset domain ARG2)
        (typeattributeset exec_type ARG1)
        (typeattributeset corenet_unlabeled_type ARG2)
        (typeattributeset entry_type ARG1)
        (typeattributeset file_type ARG1)
        (typeattributeset non_security_file_type ARG1)
        (typeattributeset non_auth_file_type ARG1)


(call usersubject_domain_type (myshell_exec_t myshell_t))
