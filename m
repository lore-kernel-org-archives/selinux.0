Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4RFusI4009840
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2003 11:56:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4RFuqtV004859
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2003 15:56:53 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h4RFuMal004832 for <selinux@tycho.nsa.gov>; Tue, 27 May 2003 15:56:39 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 0FDBDBF57
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2003 01:56:07 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 25585-08
 for <selinux@tycho.nsa.gov>; Wed, 28 May 2003 01:56:05 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 516E1BF55
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2003 01:56:05 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 92CDA92470
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2003 01:56:03 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 65DF399BC
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2003 01:55:51 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: bbwrap
Date: Wed, 28 May 2003 01:55:50 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Gq40+cOu64c5QRb"
Message-Id: <200305280155.50615.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Gq40+cOu64c5QRb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have attached the source, the configuration file, and the policy for my 
busybox-wrapper program as mentioned previously.

The program is not as functional as it should be (it should get everything it 
needs from the kernel and not need a configuration file), it has few 
comments, and may be buggy.  The policy has a number of strange things that I 
never sorted out.

I am merely posting this here for anyone who's curious.  I believe that in the 
paper I am presenting at OLS I have proven that such a wrapper is a bad idea.

As I have developed it enough to demonstrate that it is not worth doing I am 
ceasing development on it.

I have developed better solutions to the busybox problem which I describe in 
detail in my paper.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Gq40+cOu64c5QRb
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="bbwrap.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bbwrap.c"

#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <selinux/fs_secure.h>
#include <ss.h>
#include <selinux/flask_util.h>
#include <linux/flask/av_permissions.h>

#define TRANS_FILE "/etc/bbwrap.conf"

#define DO_STAT(XARGV, XBUF, XSID) \
 ((using_flask && lstat_secure(XARGV, &XBUF, &XSID)) || lstat(XARGV, &XBUF)) \
    && !S_ISLNK(XBUF.st_mode)

int main(int argc, char *argv[], char * const envp[])
{
  struct stat sbuf;
  security_id_t my_sid, link_sid, target_sid;
  struct security_query query;
  struct security_response resp;
  FILE *fp;
  char my_context[256], link_context[256], search_line[80], line[160], *tmp;
  char *command;
  int len = sizeof(my_context) - 1;
  int using_flask = is_flask_enabled();

/* check for an absolute or relative path */
  if(!(command = strrchr(argv[0], '/')) )
  {
    /* check in /bin and /sbin when no path is given */
    if( (chdir("/bin") || DO_STAT(argv[0], sbuf, link_sid) )
      && (chdir("/sbin") || DO_STAT(argv[0], sbuf, link_sid) ) )
    {
      fprintf(stderr, "Can't find sym-link %s.\n", argv[0]);
      return 2;
    }
  }
  else
  {
/* check that a sym-link is the argv[0] and get the SE type at the same time */
    if(DO_STAT(argv[0], sbuf, link_sid))
    {
      fprintf(stderr, "Can't find sym-link %s.\n", argv[0]);
      return 2;
    }
    argv[0] = command + 1;
  }

  if(!using_flask)
  {
    execve("/bin/busybox", argv, envp);
    fprintf(stderr, "Can't execute non-SE command %s.\n", argv[0]);
    return 1;
  }

  my_sid = getosecsid();

  if(security_sid_to_context(my_sid, my_context, &len))
    return 4;
  tmp = strrchr(my_context, ':');
  if(!tmp)
    return 4;
  strcpy(search_line, tmp + 1);
  strcat(search_line, " ");

  len = sizeof(link_context);
  if(security_sid_to_context(link_sid, link_context, &len))
    return 4;
  tmp = strrchr(link_context, ':');
  if(!tmp || strlen(search_line) + strlen(tmp) + 1 >= sizeof(search_line))
    return 4;
  strcat(search_line, tmp + 1);
  strcat(search_line, " ");
  len = strlen(search_line);

  fp = fopen(TRANS_FILE, "r");
  if(!fp)
  {
    fprintf(stderr, "Can't open " TRANS_FILE ".\n");
    return 5;
  }
  while(fgets(line, sizeof(line), fp))
  {
    strtok(line, "\r\n");
    if(!strncmp(search_line, line, len))
    {
      int rc, i;

      fclose(fp);

      tmp = line + len;
      strcpy(strrchr(my_context, ':') + 1, tmp);
      if(security_context_to_sid(my_context, strlen(my_context) + 1, &target_sid))
      {
        fprintf(stderr, "Can't get sid for \"%s\".\n", my_context);
        return 7;
      }
      
      query.ssid = target_sid;
      query.tsid = link_sid;
      query.tclass = SECCLASS_FILE;
      query.requested = FILE__ENTRYPOINT;
      rc = security_compute_av(&query, &resp);
      if(rc || ((query.requested & resp.allowed) != query.requested))
      {
        fprintf(stderr, "Entrypoint denied for type %s and target domain %s.\n"
              , link_context, my_context);
        return 6;
      }
      execve_secure("/bin/busybox", argv, envp, target_sid);
      fprintf(stderr, "Can't execute busybox in context %s.\n", my_context);
      return 7;
    }
  }
  fclose(fp);
  fprintf(stderr, "No configuration for domain and type combination of %s.\n"
               , search_line);
  return 5;
}

--Boundary-00=_Gq40+cOu64c5QRb
Content-Type: text/plain;
  charset="us-ascii";
  name="bbwrap.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bbwrap.conf"

init_t getty_exec_t getty_t
getty_t login_exec_t local_login_t
initrc_t klogd_exec_t klogd_t
initrc_t syslogd_exec_t syslogd_t
initrc_t mount_exec_t mount_t
sysadm_t mount_exec_t mount_t
kernel_t mount_exec_t mount_t
kernel_t insmod_exec_t insmod_t
initrc_t insmod_exec_t insmod_t
sysadm_t insmod_exec_t insmod_t
insmod_t insmod_exec_t insmod_t
cardmgr_t insmod_exec_t insmod_t
initrc_t ifconfig_exec_t ifconfig_t
sysadm_t ifconfig_exec_t ifconfig_t
initrc_t fsadm_exec_t fsadm_t
sysadm_t fsadm_exec_t fsadm_t
initrc_t hwclock_exec_t hwclock_t

--Boundary-00=_Gq40+cOu64c5QRb
Content-Type: text/plain;
  charset="us-ascii";
  name="bbwrap.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bbwrap.te"

allow bbwrap_t { ttyfile ptyfile tty_device_t }:chr_file rw_file_perms;

# dont know why we need this!
allow bbwrap_t { pppd_t hcid_t }:process signal;

# for busybox having SETUID support compiled in
dontaudit insmod_t self:capability { setgid setuid };
dontaudit hotplug_t self:capability { setgid setuid };
dontaudit getty_t self:capability { setgid setuid };
dontaudit syslogd_t self:capability { setgid setuid };
dontaudit klogd_t self:capability { setgid setuid };
dontaudit ifconfig_t self:capability { setgid setuid };
dontaudit fsadm_t self:capability { setgid setuid };
dontaudit hwclock_t self:capability { setgid setuid };
allow mount_t self:capability { setgid setuid };
dontaudit unpriv_userdomain self:capability { setgid setuid };

# for bbwrap
system_domain(bbwrap)
allow bbwrap_t privfd:fd use;
r_dir_file(bbwrap_t, etc_t)
domain_auto_trans_read({ kernel_t sysadm_t getty_t init_t initrc_t }, bbwrap_exec_t, bbwrap_t)
allow bbwrap_t { bin_t sbin_t }:dir search;
allow bbwrap_t bin_t:file read;
allow bbwrap_t security_t:security { context_to_sid compute_av sid_to_context };

define(`bbwrap_domain_enter', `
domain_trans(bbwrap_t, bin_t, $1)
allow bbwrap_t $2:lnk_file getattr;
')

bbwrap_domain_enter(insmod_t, insmod_exec_t)
bbwrap_domain_enter(local_login_t, login_exec_t)
bbwrap_domain_enter(getty_t, getty_exec_t)
bbwrap_domain_enter(klogd_t, klogd_exec_t)
bbwrap_domain_enter(syslogd_t, syslogd_exec_t)
bbwrap_domain_enter(mount_t, mount_exec_t)
bbwrap_domain_enter(ifconfig_t, ifconfig_exec_t)
bbwrap_domain_enter(fsadm_t, fsadm_exec_t)
bbwrap_domain_enter(hwclock_t, hwclock_exec_t)
bbwrap_domain_enter({ user_t sysadm_t }, shell_exec_t)

allow insmod_t insmod_exec_t:lnk_file read;
domain_auto_trans_read(insmod_t, bbwrap_exec_t, bbwrap_t)

role sysadm_r types bbwrap_t;

allow kernel_t insmod_exec_t:lnk_file read;
allow cardmgr_t insmod_exec_t:lnk_file read;
allow initrc_t klogd_exec_t:lnk_file read;
allow initrc_t syslogd_exec_t:lnk_file read;
allow initrc_t mount_exec_t:lnk_file read;
allow kernel_t mount_exec_t:lnk_file read;


--Boundary-00=_Gq40+cOu64c5QRb--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
