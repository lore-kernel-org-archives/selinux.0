Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j294DBDo021752
	for <selinux@tycho.nsa.gov>; Tue, 8 Mar 2005 23:13:11 -0500 (EST)
Received: from wproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2945uhM005138
	for <selinux@tycho.nsa.gov>; Wed, 9 Mar 2005 04:05:56 GMT
Received: by wproxy.gmail.com with SMTP id 69so93116wra
        for <selinux@tycho.nsa.gov>; Tue, 08 Mar 2005 20:08:25 -0800 (PST)
Message-ID: <fa8ec5d80503082008161e5619@mail.gmail.com>
Date: Tue, 8 Mar 2005 23:08:25 -0500
From: Kodungallur Varma <ramgwu@gmail.com>
Reply-To: Kodungallur Varma <ramgwu@gmail.com>
To: selinux@tycho.nsa.gov
Subject: problems using setcon()
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

   I am trying to dynamically change the context of my program by
using the setcon() function. I have a simple program that tries to do
that but the setcon() function always returns -1 for the input in the
program.

#include <stdio.h>
#include <selinux/selinux.h>

int main()
{
       int i;
       char str[100];
       strcpy(str,"system_u:object_r:libselinux_test_t");
       i = setcon((security_context_t) str);
       if(i == 0)
       {
               printf("changed to new context..\n");
       }
       else if(i == -1)
       {
               printf("error..setcon() returned -1\n");
       }
       else
       {
               printf("unknown result\n");
       }
       return 1;
}

libselinux_test_t is the domain in which I want this program to run. I
have the following policy for that:

-----------
     daemon_domain(libselinux_test_t)

     type libselinux_test_t, domain, privlog;
     role user_r types libselinux_test_t;

     type libselinux_test_dir_t, file_type, sysadmfile;
     type libselinux_test_exec_t, file_type, sysadmfile, exec_type;

    domain_auto_trans(user_t, libselinux_test_exec_t, libselinux_test_t)

    allow libselinux_test_t sshd_t:fd use;
------------

as I am in user_t domain when I execute the program, the program
starts in the user_t domain. but as there is that domain_auto_trans()
into the libselinux_test_t domain, setcon() into that domain soulldnt
fail for the invalid domain reasons.

I dont have any avc: denied messages as the setcon fails. my belief is
that I am passing bad arguements to setcon().

could someone please point out where the problem is. also I tried to
print out the domain of the current process using getcon(), but I have
some problem. could someone let me know how to print that out, rather
that viewing it using ps axZ.

thanx a lot in advance..

Ram


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
