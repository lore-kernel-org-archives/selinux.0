Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA10592
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 14:55:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA13088
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 19:53:12 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
        by jazzband.ncsc.mil  with ESMTP id TAA13073 for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 19:53:11 GMT
Received: from athena (athena.fwsystems.com [63.101.67.13])
	by mozart.fwsystems.com (8.11.6/8.11.6) with SMTP id gB3JtDW25632
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 14:55:13 -0500
Date: Tue, 3 Dec 2002 14:55:12 -0500
From: forrest whitcher <fw@fwsystems.com>
To: selinux@tycho.nsa.gov
Subject: Odd fork/vfork failure / hang running selinux kerenel in slackware - current
Message-Id: <20021203145512.7d3fd39f.fw@fwsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__3_Dec_2002_14:55:12_-0500_09dd08e0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart_Tue__3_Dec_2002_14:55:12_-0500_09dd08e0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


I'm attempting to setup a full working configuration for SELinux on slackware,
which is mostly working well (openssh, apache, mod-ssl, standard net utils are all
working in enforcing mode, with just a few lines of edits to the policy
config files).


However on building MIT kerberos I ran across a 'hang' in the ./configure
process which turned out to be a problem in vfork (&fork). The test code 
extracted from ./configure and modified to dig out the issue is posted
below. Originally it was a vfork() test. The vfork configuration test
never returns.



The system under test is using gcc 3.2 and glibc 2.3.1.

This problem replicated only on slackware with the selinux kernel 
(enforcing or permissive mode), I've tested on 2 identical machines
which were running the selinux kernel with essentally identical
kernel .config's 

fork(), vfork() works normally:

redhat 7.1            gcc 2.96 / glibc 2.2.5 selinux kernel
'lunar' (source-dist) gcc 3.2 /  glibc 2.3.1 selinux kernel
slackware -current    gcc 3.2 /  glibc 2.3.1 stock kernel

fork problem:

slackware -current    gcc 3.2 /  glibc 2.3.1 selinux kernel


Finaly, this issue does not present itself in the following circomstances:

If the current shell is not /bin/bash. running csh and then testing, or 
running csh, then invoking bash gives expected behavior ??! I have also
found that I get 'normal' behavior if I am in role user_r, fork failures
after 'newrole -r sysadm_r'.

Any ideas what the heck is going on with this?

forrest


Attached file slowfork2.c --- I very much doubt this problem is going to
replicate anyplace but on the slackware-current + selinux config, however
it's attached so you can see the 

compile and run:      

Bash 2.05b$ ./slowfork2 nloops

Code snippet:

The inserted while loop below to is used kill some time and determine 
how much of a delay is needed in order for the fork to work properly
giving wait() something to actually do, values for ii ca 1-2 *10^6 
(on a pIII/900) are in the range of what's needed to allow 'correct' 
operation --- probably a 1-10 ms delay.


  child = fork ();
  if (child == 0) {
    printf ("Main :4(postforkchld=0)\n");

    pid_t p = getpid();

/* allow fork() to complete??? */

    while (i <= ii){
      i++;
    }

    printf ("Getpid = %d %d\n", p, ii);
    pid_t  p1 = getpid(), p2 = getpid(), p3 = getpid() ;

    /* Convince the compiler that p..p7 are live; otherwise, it might
       use the same hardware register for all 8 local variables.  */

    if (p != p1 || p != p2 || p != p3 )
      _exit(1);

  } else {
    printf ("Main :5postforkchld !=0\n");
    int status;
    struct stat st;

    while (wait(&status) != child){
      printf ("Main :6 status = %d\n", status);
      sleep(1);
      }
      printf ("Main :7 got to exit\n");
    exit(
         /* Was there some problem with vforking?  */
         child < 0

         /* Did the child fail?  (This shouldn't happen.)  */
         || status

         /* Did the vfork/compiler bug occur?  */
         || parent != getpid()

         /* Did the file descriptor bug occur?  */
         || fstat(fileno(stdout), &st) != 0
         );
  }

--Multipart_Tue__3_Dec_2002_14:55:12_-0500_09dd08e0
Content-Type: application/octet-stream;
 name="slowfork2.c"
Content-Disposition: attachment;
 filename="slowfork2.c"
Content-Transfer-Encoding: base64

I2xpbmUgMjMzNCAiY29uZmlndXJlIgovKiBUaGFua3MgdG8gUGF1bCBFZ2dlcnQgZm9yIHRoaXMg
dGVzdC4gICovCiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNs
dWRlIDxzeXMvc3RhdC5oPgojaWZkZWYgSEFWRV9VTklTVERfSAojaW5jbHVkZSA8dW5pc3RkLmg+
CiNlbmRpZgojaWZkZWYgSEFWRV9WRk9SS19ICiNpbmNsdWRlIDx2Zm9yay5oPgojZW5kaWYKLyog
T24gc29tZSBzcGFyYyBzeXN0ZW1zLCBjaGFuZ2VzIGJ5IHRoZSBjaGlsZCB0byBsb2NhbCBhbmQg
aW5jb21pbmcKICAgYXJndW1lbnQgcmVnaXN0ZXJzIGFyZSBwcm9wYWdhdGVkIGJhY2sgdG8gdGhl
IHBhcmVudC4KICAgVGhlIGNvbXBpbGVyIGlzIHRvbGQgYWJvdXQgdGhpcyB3aXRoICNpbmNsdWRl
IDx2Zm9yay5oPiwKICAgYnV0IHNvbWUgY29tcGlsZXJzIChlLmcuIGdjYyAtTykgZG9uJ3QgZ3Jv
ayA8dmZvcmsuaD4uCiAgIFRlc3QgZm9yIHRoaXMgYnkgdXNpbmcgYSBzdGF0aWMgdmFyaWFibGUg
d2hvc2UgYWRkcmVzcwogICBpcyBwdXQgaW50byBhIHJlZ2lzdGVyIHRoYXQgaXMgY2xvYmJlcmVk
IGJ5IHRoZSB2Zm9yay4gICovCm1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkgewogIHByaW50
ZiAoIk1haW4gOjBcbiIpOwogIHBpZF90IHBhcmVudCA9IGdldHBpZCAoKTsKICBwcmludGYgKCJN
YWluIDoxXG4iKTsKICBwaWRfdCBjaGlsZDsKICBwcmludGYgKCJNYWluIDoyXG4iKTsKICBsb25n
IGk9MCwgaWk9YXRvaShhcmd2WzFdKTsKCiAgcHJpbnRmICgiTWFpbiA6MyhzcHQpXG4iKTsKICBj
aGlsZCA9IGZvcmsgKCk7CiAgaWYgKGNoaWxkID09IDApIHsKICAgIHByaW50ZiAoIk1haW4gOjQo
cG9zdGZvcmtjaGxkPTApXG4iKTsKCiAgICAvKiBIZXJlIGlzIGFub3RoZXIgdGVzdCBmb3Igc3Bh
cmMgdmZvcmsgcmVnaXN0ZXIgcHJvYmxlbXMuCiAgICAgICBUaGlzIHRlc3QgdXNlcyBsb3RzIG9m
IGxvY2FsIHZhcmlhYmxlcywgYXQgbGVhc3QKICAgICAgIGFzIG1hbnkgbG9jYWwgdmFyaWFibGVz
IGFzIG1haW4gaGFzIGFsbG9jYXRlZCBzbyBmYXIKICAgICAgIGluY2x1ZGluZyBjb21waWxlciB0
ZW1wb3Jhcmllcy4gIDQgbG9jYWxzIGFyZSBlbm91Z2ggZm9yCiAgICAgICBnY2MgMS40MC4zIG9u
IGEgU29sYXJpcyA0LjEuMyBzcGFyYywgYnV0IHdlIHVzZSA4IHRvIGJlIHNhZmUuCiAgICAgICBB
IGJ1Z2d5IGNvbXBpbGVyIHNob3VsZCByZXVzZSB0aGUgcmVnaXN0ZXIgb2YgcGFyZW50CiAgICAg
ICBmb3Igb25lIG9mIHRoZSBsb2NhbCB2YXJpYWJsZXMsIHNpbmNlIGl0IHdpbGwgdGhpbmsgdGhh
dAogICAgICAgcGFyZW50IGNhbid0IHBvc3NpYmx5IGJlIHVzZWQgYW55IG1vcmUgaW4gdGhpcyBy
b3V0aW5lLgogICAgICAgQXNzaWduaW5nIHRvIHRoZSBsb2NhbCB2YXJpYWJsZSB3aWxsIHRodXMg
bXVuZ2UgcGFyZW50CiAgICAgICBpbiB0aGUgcGFyZW50IHByb2Nlc3MuICAqLwogICAgcGlkX3Qg
cCA9IGdldHBpZCgpOwogICAgd2hpbGUgKGkgPD0gaWkpewogICAgICBpKys7CiAgICB9CiAgICBw
cmludGYgKCJHZXRwaWQgPSAlZCAlZFxuIiwgcCwgaWkpOwogICAgcGlkX3QgIHAxID0gZ2V0cGlk
KCksIHAyID0gZ2V0cGlkKCksIHAzID0gZ2V0cGlkKCkgOwogICAgLyogQ29udmluY2UgdGhlIGNv
bXBpbGVyIHRoYXQgcC4ucDcgYXJlIGxpdmU7IG90aGVyd2lzZSwgaXQgbWlnaHQKICAgICAgIHVz
ZSB0aGUgc2FtZSBoYXJkd2FyZSByZWdpc3RlciBmb3IgYWxsIDggbG9jYWwgdmFyaWFibGVzLiAg
Ki8KICAgIGlmIChwICE9IHAxIHx8IHAgIT0gcDIgfHwgcCAhPSBwMyApCiAgICAgIF9leGl0KDEp
OwoKICAgIC8qIE9uIHNvbWUgc3lzdGVtcyAoZS5nLiBJUklYIDMuMyksCiAgICAgICB2Zm9yayBk
b2Vzbid0IHNlcGFyYXRlIHBhcmVudCBmcm9tIGNoaWxkIGZpbGUgZGVzY3JpcHRvcnMuCiAgICAg
ICBJZiB0aGUgY2hpbGQgY2xvc2VzIGEgZGVzY3JpcHRvciBiZWZvcmUgaXQgZXhlY3Mgb3IgZXhp
dHMsCiAgICAgICB0aGlzIG11bmdlcyB0aGUgcGFyZW50J3MgZGVzY3JpcHRvciBhcyB3ZWxsLgog
ICAgICAgVGVzdCBmb3IgdGhpcyBieSBjbG9zaW5nIHN0ZG91dCBpbiB0aGUgY2hpbGQuICAqLwog
ICAgX2V4aXQoY2xvc2UoZmlsZW5vKHN0ZG91dCkpICE9IDApOwogIH0gZWxzZSB7CiAgICBwcmlu
dGYgKCJNYWluIDo1cG9zdGZvcmtjaGxkICE9MFxuIik7CiAgICBpbnQgc3RhdHVzOwogICAgc3Ry
dWN0IHN0YXQgc3Q7CgogICAgd2hpbGUgKHdhaXQoJnN0YXR1cykgIT0gY2hpbGQpewogICAgICBw
cmludGYgKCJNYWluIDo2IHN0YXR1cyA9ICVkXG4iLCBzdGF0dXMpOwogICAgICBzbGVlcCgxKTsK
ICAgICAgfQogICAgICBwcmludGYgKCJNYWluIDo3IGdvdCB0byBleGl0XG4iKTsKICAgIGV4aXQo
CgkgLyogV2FzIHRoZXJlIHNvbWUgcHJvYmxlbSB3aXRoIHZmb3JraW5nPyAgKi8KCSBjaGlsZCA8
IDAKCgkgLyogRGlkIHRoZSBjaGlsZCBmYWlsPyAgKFRoaXMgc2hvdWxkbid0IGhhcHBlbi4pICAq
LwoJIHx8IHN0YXR1cwoKCSAvKiBEaWQgdGhlIHZmb3JrL2NvbXBpbGVyIGJ1ZyBvY2N1cj8gICov
CgkgfHwgcGFyZW50ICE9IGdldHBpZCgpCgoJIC8qIERpZCB0aGUgZmlsZSBkZXNjcmlwdG9yIGJ1
ZyBvY2N1cj8gICovCgkgfHwgZnN0YXQoZmlsZW5vKHN0ZG91dCksICZzdCkgIT0gMAoJICk7CiAg
fQp9Cg==

--Multipart_Tue__3_Dec_2002_14:55:12_-0500_09dd08e0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
