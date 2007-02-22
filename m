From: Steve Grubb <sgrubb@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: I think this is equivalent to what we have =?iso-8859-1?q?now=09and=09more=09efficient=2E?=
Date: Thu, 22 Feb 2007 11:56:48 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
References: <45DDAA80.80603@redhat.com> <1172159012.14363.404.camel@moss-spartans.epoch.ncsc.mil> <45DDBEFA.3050901@redhat.com>
In-Reply-To: <45DDBEFA.3050901@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702221156.49050.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 22 February 2007 11:04:10 Daniel J Walsh wrote:
>     fp = fopen("/proc/filesystems", "r");
>     if (fp == NULL)
>         return -1;

This avoids speedups if selinux_mnt already determined that selinux file 
system is mounted.

>     while ((read = getline(&line, &len, fp)) != -1) {

calls malloc/realloc sometimes. Do we want to use this or just use 
fgets_unlocked?

>         if (strstr(line, "selinuxfs")) {
>             enabled=1;
>             break;
>         }
>     }

check for policy loaded ?

>     free(line);
>     fclose(fp);
>     return enabled;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
