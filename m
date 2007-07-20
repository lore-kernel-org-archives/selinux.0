Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6KEICJR028255
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 10:18:12 -0400
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6KEIBHO018098
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 14:18:11 GMT
Received: by nz-out-0506.google.com with SMTP id l1so780083nzf
        for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 07:18:11 -0700 (PDT)
Message-ID: <cadfc0e40707200718n67a4844dx4a8afc0ff88e5092@mail.gmail.com>
Date: Fri, 20 Jul 2007 09:18:10 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: Re: New test program for libselinux/utils that helped with testing MLS/Role/Level coding
In-Reply-To: <46A0A981.9060703@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_136997_5174752.1184941090645"
References: <45A68F43.3050101@redhat.com> <469E8622.3070309@gmail.com>
	 <46A0A981.9060703@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_136997_5174752.1184941090645
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's an strace log. A write to /selinux/context is failing, any idea why?

On 7/20/07, Ted X Toth <txtoth@gmail.com> wrote:
> Ted X Toth wrote:
> > Daniel J Walsh wrote:
> >> getdefaultcon.c
> >> ------------------------------------------------------------------------
> >>
> >> diff --exclude-from=exclude -N -u -r
> >> nsalibselinux/utils/getdefaultcon.c
> >> libselinux-1.33.4/utils/getdefaultcon.c
> >> --- nsalibselinux/utils/getdefaultcon.c    1969-12-31
> >> 19:00:00.000000000 -0500
> >> +++ libselinux-1.33.4/utils/getdefaultcon.c    2007-01-11
> >> 14:24:24.000000000 -0500
> >> @@ -0,0 +1,75 @@
> >> +#include <unistd.h>
> >> +#include <sys/types.h>
> >> +#include <fcntl.h>
> >> +#include <stdio.h>
> >> +#include <stdlib.h>
> >> +#include <errno.h>
> >> +#include <string.h>
> >> +#include <ctype.h>
> >> +#include <selinux/selinux.h>
> >> +#include <selinux/get_context_list.h>
> >> +
> >> +void usage(char *name, char *detail, int rc)
> >> +{
> >> +    fprintf(stderr, "usage:  %s [-l level] user fromcon\n", name);
> >> +    if (detail)
> >> +        fprintf(stderr, "%s:  %s\n", name, detail);
> >> +    exit(rc);
> >> +}
> >> +
> >> +int main(int argc, char **argv)
> >> +{
> >> +    security_context_t usercon = NULL, cur_context = NULL;
> >> +    char *user = NULL, *level = NULL, *role=NULL, *seuser=NULL;
> >> +    int ret, opt;
> >> +
> >> +    while ((opt = getopt(argc, argv, "l:r:")) > 0) {
> >> +        switch (opt) {
> >> +        case 'l':
> >> +            level = strdup(optarg);
> >> +            break;
> >> +        case 'r':
> >> +            role = strdup(optarg);
> >> +            break;
> >> +        default:
> >> +            usage(argv[0], "invalid option", 1);
> >> +        }
> >> +    }
> >> +
> >> +    if (((argc - optind) < 1) || ((argc - optind) > 2))
> >> +        usage(argv[0], "invalid number of arguments", 2);
> >> +
> >> +    /* If selinux isn't available, bail out. */
> >> +    if (!is_selinux_enabled()) {
> >> +        fprintf(stderr,
> >> +            "%s may be used only on a SELinux kernel.\n", argv[0]);
> >> +        return 1;
> >> +    }
> >> +
> >> +    user = argv[optind];
> >> +
> >> +    /* If a context wasn't passed, use the current context. */
> >> +    if (((argc - optind) < 2)) {
> >> +        if (getcon(&cur_context) < 0) {
> >> +            fprintf(stderr, "Couldn't get current context.\n");
> >> +            return 2;
> >> +        }
> >> +    } else
> >> +        cur_context = argv[optind + 1];
> >> +
> >> +    if (getseuserbyname(user, &seuser, &level)==0) {
> >> +        if (role != NULL && role[0]) +
> >> ret=get_default_context_with_rolelevel(seuser, role,
> >> level,cur_context,&usercon);
> >> +        else
> >> +            ret=get_default_context_with_level(seuser, level,
> >> cur_context,&usercon);
> >> +    }
> >> +    if (ret < 0)
> >> +        perror(argv[0]);
> >> +    else
> >> +        printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user,
> >> cur_context, seuser, role, level, usercon);
> >> +
> >> +
> >> +    free(usercon);
> >> +
> >> +    return 0;
> >> +}
> >>
> > I tried running this test program on RHEL 5 and
> > get_default_context_with_level fails with "Invalid argument". I
> > supplied a valid linux user name and verified that getseuserbyname
> > returned 'user_u' and  's0' for the user and level respectively. I did
> > this because some other code which runs on fc6 where  I use
> > get_default_context_with_level also failed with the same error when I
> > ran it on RHEL 5.
> >
> I worked on figuring out exactly when this failure occurs and have
> narrowed it down to running MLS policy on rhel5 updated with LSPP rpms
> from Steve Grubbs repo. Here are the exact steps I took to get to the
> failure.
>
> 1) installed rhel5, test code succeeds
> 2) update from sgrubb repo . reboot. test code succeeds (mls policy not
> updated because it is not installed as part of rhel5)
> 3) install mls policy from sgrubb repo and reconfigure system to use it.
> reboot. test code fails
>
> Ted
>

------=_Part_136997_5174752.1184941090645
Content-Type: text/x-log; name=test1.log; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4cr9x5u
Content-Disposition: attachment; filename="test1.log"

ZXhlY3ZlKCIuL3Rlc3QxIiwgWyIuL3Rlc3QxIl0sIFsvKiAzNSB2YXJzICovXSkgPSAwCmJyaygw
KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4ODM3YzAwMAptbWFwMihOVUxM
LCA0MDk2LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VUywg
LTEsIDApID0gMHhiN2ZjZTAwMAphY2Nlc3MoIi9ldGMvbGQuc28ucHJlbG9hZCIsIFJfT0spICAg
ICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9ldGMvbGQu
c28uY2FjaGUiLCBPX1JET05MWSkgICAgICA9IDMKZnN0YXQ2NCgzLCB7c3RfbW9kZT1TX0lGUkVH
fDA2NDQsIHN0X3NpemU9NjEwNDYsIC4uLn0pID0gMAptbWFwMihOVUxMLCA2MTA0NiwgUFJPVF9S
RUFELCBNQVBfUFJJVkFURSwgMywgMCkgPSAweGI3ZmJmMDAwCmNsb3NlKDMpICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA9IDAKb3BlbigiL2xpYi9saWJzZWxpbnV4LnNvLjEiLCBPX1JE
T05MWSkgID0gMwpyZWFkKDMsICJcMTc3RUxGXDFcMVwxXDBcMFwwXDBcMFwwXDBcMFwwXDNcMFwz
XDBcMVwwXDBcMFwyMGU+XDAwMCIuLi4sIDUxMikgPSA1MTIKZnN0YXQ2NCgzLCB7c3RfbW9kZT1T
X0lGUkVHfDA3NTUsIHN0X3NpemU9OTM1MTIsIC4uLn0pID0gMAptbWFwMigweDNlMzAwMCwgOTMw
MTYsIFBST1RfUkVBRHxQUk9UX0VYRUMsIE1BUF9QUklWQVRFfE1BUF9ERU5ZV1JJVEUsIDMsIDAp
ID0gMHgzZTMwMDAKbW1hcDIoMHgzZjgwMDAsIDgxOTIsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBN
QVBfUFJJVkFURXxNQVBfRklYRUR8TUFQX0RFTllXUklURSwgMywgMHgxNSkgPSAweDNmODAwMApj
bG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCm9wZW4oIi9saWIvbGli
Yy5zby42IiwgT19SRE9OTFkpICAgICAgICA9IDMKcmVhZCgzLCAiXDE3N0VMRlwxXDFcMVwwXDBc
MFwwXDBcMFwwXDBcMFwzXDBcM1wwXDFcMFwwXDAwMDBvXDIxIi4uLiwgNTEyKSA9IDUxMgpmc3Rh
dDY0KDMsIHtzdF9tb2RlPVNfSUZSRUd8MDc1NSwgc3Rfc2l6ZT0xNTc2OTUyLCAuLi59KSA9IDAK
bW1hcDIoMHgxMDEwMDAsIDEyOTU3ODAsIFBST1RfUkVBRHxQUk9UX0VYRUMsIE1BUF9QUklWQVRF
fE1BUF9ERU5ZV1JJVEUsIDMsIDApID0gMHgyMTYwMDAKbW1hcDIoMHgzNGQwMDAsIDEyMjg4LCBQ
Uk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0ZJWEVEfE1BUF9ERU5ZV1JJVEUs
IDMsIDB4MTM3KSA9IDB4MzRkMDAwCm1tYXAyKDB4MzUwMDAwLCA5NjM2LCBQUk9UX1JFQUR8UFJP
VF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0ZJWEVEfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4
MzUwMDAwCmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKb3Blbigi
L2xpYi9saWJkbC5zby4yIiwgT19SRE9OTFkpICAgICAgID0gMwpyZWFkKDMsICJcMTc3RUxGXDFc
MVwxXDBcMFwwXDBcMFwwXDBcMFwwXDNcMFwzXDBcMVwwXDBcMFBqXDMyN1wwMDAiLi4uLCA1MTIp
ID0gNTEyCmZzdGF0NjQoMywge3N0X21vZGU9U19JRlJFR3wwNzU1LCBzdF9zaXplPTE2NTI4LCAu
Li59KSA9IDAKbW1hcDIoMHhkNzYwMDAsIDEyNDA4LCBQUk9UX1JFQUR8UFJPVF9FWEVDLCBNQVBf
UFJJVkFURXxNQVBfREVOWVdSSVRFLCAzLCAwKSA9IDB4ZDc2MDAwCm1tYXAyKDB4ZDc4MDAwLCA4
MTkyLCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0ZJWEVEfE1BUF9ERU5Z
V1JJVEUsIDMsIDB4MSkgPSAweGQ3ODAwMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgPSAwCm9wZW4oIi9saWIvbGlic2Vwb2wuc28uMSIsIE9fUkRPTkxZKSAgICA9IDMK
cmVhZCgzLCAiXDE3N0VMRlwxXDFcMVwwXDBcMFwwXDBcMFwwXDBcMFwzXDBcM1wwXDFcMFwwXDBc
MzQwXDMzNiIuLi4sIDUxMikgPSA1MTIKZnN0YXQ2NCgzLCB7c3RfbW9kZT1TX0lGUkVHfDA3NTUs
IHN0X3NpemU9MjQyODgwLCAuLi59KSA9IDAKbW1hcDIoMHgzOWIwMDAsIDI4NjYyNCwgUFJPVF9S
RUFEfFBST1RfRVhFQywgTUFQX1BSSVZBVEV8TUFQX0RFTllXUklURSwgMywgMCkgPSAweDM5YjAw
MAptbWFwMigweDNkNjAwMCwgNDA5NiwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRF
fE1BUF9GSVhFRHxNQVBfREVOWVdSSVRFLCAzLCAweDNhKSA9IDB4M2Q2MDAwCm1tYXAyKDB4M2Q3
MDAwLCA0MDg2NCwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9GSVhFRHxN
QVBfQU5PTllNT1VTLCAtMSwgMCkgPSAweDNkNzAwMApjbG9zZSgzKSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPSAwCm1tYXAyKE5VTEwsIDQwOTYsIFBST1RfUkVBRHxQUk9UX1dSSVRF
LCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkgPSAweGI3ZmJlMDAwCm1tYXAyKE5V
TEwsIDQwOTYsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VT
LCAtMSwgMCkgPSAweGI3ZmJkMDAwCnNldF90aHJlYWRfYXJlYSh7ZW50cnlfbnVtYmVyOi0xIC0+
IDYsIGJhc2VfYWRkcjoweGI3ZmJkNmQwLCBsaW1pdDoxMDQ4NTc1LCBzZWdfMzJiaXQ6MSwgY29u
dGVudHM6MCwgcmVhZF9leGVjX29ubHk6MCwgbGltaXRfaW5fcGFnZXM6MSwgc2VnX25vdF9wcmVz
ZW50OjAsIHVzZWFibGU6MX0pID0gMAptcHJvdGVjdCgweGQ3ODAwMCwgNDA5NiwgUFJPVF9SRUFE
KSAgICAgPSAwCm1wcm90ZWN0KDB4MzRkMDAwLCA4MTkyLCBQUk9UX1JFQUQpICAgICA9IDAKbXBy
b3RlY3QoMHgzOTcwMDAsIDQwOTYsIFBST1RfUkVBRCkgICAgID0gMAptdW5tYXAoMHhiN2ZiZjAw
MCwgNjEwNDYpICAgICAgICAgICAgICAgPSAwCmFjY2VzcygiL2V0Yy9zZWxpbnV4LyIsIEZfT0sp
ICAgICAgICAgICA9IDAKYnJrKDApICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0g
MHg4MzdjMDAwCmJyaygweDgzOWQwMDApICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4ODM5
ZDAwMApvcGVuKCIvZXRjL3NlbGludXgvY29uZmlnIiwgT19SRE9OTFl8T19MQVJHRUZJTEUpID0g
Mwpmc3RhdDY0KDMsIHtzdF9tb2RlPVNfSUZSRUd8MDY0NCwgc3Rfc2l6ZT01MDgsIC4uLn0pID0g
MAptbWFwMihOVUxMLCA0MDk2LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQ
X0FOT05ZTU9VUywgLTEsIDApID0gMHhiN2ZjZDAwMApyZWFkKDMsICIjIFRoaXMgZmlsZSBjb250
cm9scyB0aGUgc3RhdGUgbyIuLi4sIDQwOTYpID0gNTA4CnJlYWQoMywgIiIsIDQwOTYpICAgICAg
ICAgICAgICAgICAgICAgICA9IDAKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgID0gMAptdW5tYXAoMHhiN2ZjZDAwMCwgNDA5NikgICAgICAgICAgICAgICAgPSAwCm9wZW4o
Ii9wcm9jL21vdW50cyIsIE9fUkRPTkxZfE9fTEFSR0VGSUxFKSA9IDMKZnN0YXQ2NCgzLCB7c3Rf
bW9kZT1TX0lGUkVHfDA0NDQsIHN0X3NpemU9MCwgLi4ufSkgPSAwCm1tYXAyKE5VTEwsIDQwOTYs
IFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkg
PSAweGI3ZmNkMDAwCnJlYWQoMywgInJvb3RmcyAvIHJvb3RmcyBydyAwIDBcbi9kZXYvcm9vdCIu
Li4sIDQwOTYpID0gNTc3CmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9
IDAKbXVubWFwKDB4YjdmY2QwMDAsIDQwOTYpICAgICAgICAgICAgICAgID0gMApvcGVuKCIvc2Vs
aW51eC9tbHMiLCBPX1JET05MWXxPX0xBUkdFRklMRSkgPSAzCnJlYWQoMywgIjEiLCAxOSkgICAg
ICAgICAgICAgICAgICAgICAgICA9IDEKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgID0gMApzb2NrZXQoUEZfRklMRSwgU09DS19TVFJFQU0sIDApICAgICAgICAgPSAzCmNv
bm5lY3QoMywge3NhX2ZhbWlseT1BRl9GSUxFLCBwYXRoPSIvdmFyL3J1bi9zZXRyYW5zLy5zZXRy
YW5zLXVuaXgifSwgMTEwKSA9IDAKc2VuZG1zZygzLCB7bXNnX25hbWUoMCk9TlVMTCwgbXNnX2lv
dig1KT1beyJcMVwwXDBcMCIsIDR9LCB7IlwxXDBcMFwwIiwgNH0sIHsiXDFcMFwwXDAiLCA0fSwg
eyJcMCIsIDF9LCB7IlwwIiwgMX1dLCBtc2dfY29udHJvbGxlbj0wLCBtc2dfZmxhZ3M9MH0sIE1T
R19OT1NJR05BTCkgPSAxNApyZWFkdigzLCBbeyJcMVwwXDBcMCIsIDR9LCB7IlwxXDBcMFwwIiwg
NH0sIHsiXDBcMFwwXDAiLCA0fV0sIDMpID0gMTIKcmVhZHYoMywgW3siXDAiLCAxfV0sIDEpICAg
ICAgICAgICAgICAgID0gMQpjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
PSAwCm9wZW4oIi9zZWxpbnV4L21scyIsIE9fUkRPTkxZfE9fTEFSR0VGSUxFKSA9IDMKcmVhZCgz
LCAiMSIsIDE5KSAgICAgICAgICAgICAgICAgICAgICAgID0gMQpjbG9zZSgzKSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgPSAwCm9wZW4oIi9ldGMvc2VsaW51eC9tbHMvc2V1c2VycyIs
IE9fUkRPTkxZfE9fTEFSR0VGSUxFKSA9IDMKZnN0YXQ2NCgzLCB7c3RfbW9kZT1TX0lGUkVHfDA2
NDQsIHN0X3NpemU9ODIsIC4uLn0pID0gMAptbWFwMihOVUxMLCA0MDk2LCBQUk9UX1JFQUR8UFJP
VF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VUywgLTEsIDApID0gMHhiN2ZjZDAwMApy
ZWFkKDMsICJzeXN0ZW1fdTpzeXN0ZW1fdTpzMC1zMTU6YzAuYzEwMiIuLi4sIDQwOTYpID0gODIK
cmVhZCgzLCAiIiwgNDA5NikgICAgICAgICAgICAgICAgICAgICAgID0gMApjbG9zZSgzKSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCm11bm1hcCgweGI3ZmNkMDAwLCA0MDk2KSAg
ICAgICAgICAgICAgICA9IDAKZnN0YXQ2NCgxLCB7c3RfbW9kZT1TX0lGQ0hSfDA2MjAsIHN0X3Jk
ZXY9bWFrZWRldigxMzYsIDEpLCAuLi59KSA9IDAKbW1hcDIoTlVMTCwgNDA5NiwgUFJPVF9SRUFE
fFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4YjdmY2Qw
MDAKd3JpdGUoMSwgInVzZXJfdSBzMFxuIiwgMTApICAgICAgICAgICAgID0gMTAKZ2V0dGlkKCkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMjQwMQpvcGVuKCIvcHJvYy9zZWxmL3Rh
c2svMjQwMS9hdHRyL2N1cnJlbnQiLCBPX1JET05MWXxPX0xBUkdFRklMRSkgPSAzCnJlYWQoMywg
InJvb3Q6c3lzYWRtX3I6c3lzYWRtX3Q6czBcMCIsIDQwOTUpID0gMjYKY2xvc2UoMykgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgID0gMApzb2NrZXQoUEZfRklMRSwgU09DS19TVFJFQU0s
IDApICAgICAgICAgPSAzCmNvbm5lY3QoMywge3NhX2ZhbWlseT1BRl9GSUxFLCBwYXRoPSIvdmFy
L3J1bi9zZXRyYW5zLy5zZXRyYW5zLXVuaXgifSwgMTEwKSA9IDAKc2VuZG1zZygzLCB7bXNnX25h
bWUoMCk9TlVMTCwgbXNnX2lvdig1KT1beyJcMlwwXDBcMCIsIDR9LCB7IlwzMlwwXDBcMCIsIDR9
LCB7IlwxXDBcMFwwIiwgNH0sIHsicm9vdDpzeXNhZG1fcjpzeXNhZG1fdDpzMFwwIiwgMjZ9LCB7
IlwwIiwgMX1dLCBtc2dfY29udHJvbGxlbj0wLCBtc2dfZmxhZ3M9MH0sIE1TR19OT1NJR05BTCkg
PSAzOQpyZWFkdigzLCBbeyJcMlwwXDBcMCIsIDR9LCB7IiFcMFwwXDAiLCA0fSwgeyJcMFwwXDBc
MCIsIDR9XSwgMykgPSAxMgpyZWFkdigzLCBbeyJyb290OnN5c2FkbV9yOnN5c2FkbV90OlN5c3Rl
bUxvdyIuLi4sIDMzfV0sIDEpID0gMzMKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgID0gMApzb2NrZXQoUEZfRklMRSwgU09DS19TVFJFQU0sIDApICAgICAgICAgPSAzCmNv
bm5lY3QoMywge3NhX2ZhbWlseT1BRl9GSUxFLCBwYXRoPSIvdmFyL3J1bi9zZXRyYW5zLy5zZXRy
YW5zLXVuaXgifSwgMTEwKSA9IDAKc2VuZG1zZygzLCB7bXNnX25hbWUoMCk9TlVMTCwgbXNnX2lv
dig1KT1beyJcM1wwXDBcMCIsIDR9LCB7IiFcMFwwXDAiLCA0fSwgeyJcMVwwXDBcMCIsIDR9LCB7
InJvb3Q6c3lzYWRtX3I6c3lzYWRtX3Q6U3lzdGVtTG93Ii4uLiwgMzN9LCB7IlwwIiwgMX1dLCBt
c2dfY29udHJvbGxlbj0wLCBtc2dfZmxhZ3M9MH0sIE1TR19OT1NJR05BTCkgPSA0NgpyZWFkdigz
LCBbeyJcM1wwXDBcMCIsIDR9LCB7IlwzMlwwXDBcMCIsIDR9LCB7IlwwXDBcMFwwIiwgNH1dLCAz
KSA9IDEyCnJlYWR2KDMsIFt7InJvb3Q6c3lzYWRtX3I6c3lzYWRtX3Q6czBcMCIsIDI2fV0sIDEp
ID0gMjYKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMApvcGVuKCIv
c2VsaW51eC91c2VyIiwgT19SRFdSfE9fTEFSR0VGSUxFKSA9IDMKd3JpdGUoMywgInJvb3Q6c3lz
YWRtX3I6c3lzYWRtX3Q6czAgdXNlcl91IiwgMzIpID0gMzIKcmVhZCgzLCAiMFwwIiwgNDA5NSkg
ICAgICAgICAgICAgICAgICAgID0gMgpjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgPSAwCm9wZW4oIi9ldGMvc2VsaW51eC9tbHMvY29udGV4dHMvZmFpbHNhZmVfY29udGV4
dCIsIE9fUkRPTkxZfE9fTEFSR0VGSUxFKSA9IDMKZnN0YXQ2NCgzLCB7c3RfbW9kZT1TX0lGUkVH
fDA2NDQsIHN0X3NpemU9MjEsIC4uLn0pID0gMAptbWFwMihOVUxMLCA0MDk2LCBQUk9UX1JFQUR8
UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VUywgLTEsIDApID0gMHhiN2ZjYzAw
MApyZWFkKDMsICJzeXNhZG1fcjpzeXNhZG1fdDpzMFxuIiwgNDA5NikgPSAyMQpjbG9zZSgzKSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCm11bm1hcCgweGI3ZmNjMDAwLCA0MDk2
KSAgICAgICAgICAgICAgICA9IDAKc29ja2V0KFBGX0ZJTEUsIFNPQ0tfU1RSRUFNLCAwKSAgICAg
ICAgID0gMwpjb25uZWN0KDMsIHtzYV9mYW1pbHk9QUZfRklMRSwgcGF0aD0iL3Zhci9ydW4vc2V0
cmFucy8uc2V0cmFucy11bml4In0sIDExMCkgPSAwCnNlbmRtc2coMywge21zZ19uYW1lKDApPU5V
TEwsIG1zZ19pb3YoNSk9W3siXDNcMFwwXDAiLCA0fSwgeyJcMzRcMFwwXDAiLCA0fSwgeyJcMVww
XDBcMCIsIDR9LCB7InVzZXJfdTpzeXNhZG1fcjpzeXNhZG1fdDpzMFwwIiwgMjh9LCB7IlwwIiwg
MX1dLCBtc2dfY29udHJvbGxlbj0wLCBtc2dfZmxhZ3M9MH0sIE1TR19OT1NJR05BTCkgPSA0MQpy
ZWFkdigzLCBbeyJcM1wwXDBcMCIsIDR9LCB7IlwzNFwwXDBcMCIsIDR9LCB7IlwwXDBcMFwwIiwg
NH1dLCAzKSA9IDEyCnJlYWR2KDMsIFt7InVzZXJfdTpzeXNhZG1fcjpzeXNhZG1fdDpzMFwwIiwg
Mjh9XSwgMSkgPSAyOApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAw
Cm9wZW4oIi9zZWxpbnV4L2NvbnRleHQiLCBPX1JEV1J8T19MQVJHRUZJTEUpID0gMwp3cml0ZSgz
LCAidXNlcl91OnN5c2FkbV9yOnN5c2FkbV90OnMwXDAiLCAyOCkgPSAtMSBFSU5WQUwgKEludmFs
aWQgYXJndW1lbnQpCmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAK
d3JpdGUoMSwgIi0xIDogZGVmYXVsdCBjb250ZXh0IChudWxsKSBcbiIsIDI5KSA9IDI5CmdldHRp
ZCgpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDI0MDEKb3BlbigiL3Byb2Mvc2Vs
Zi90YXNrLzI0MDEvYXR0ci9jdXJyZW50IiwgT19SRE9OTFl8T19MQVJHRUZJTEUpID0gMwpyZWFk
KDMsICJyb290OnN5c2FkbV9yOnN5c2FkbV90OnMwXDAiLCA0MDk1KSA9IDI2CmNsb3NlKDMpICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKc29ja2V0KFBGX0ZJTEUsIFNPQ0tfU1RS
RUFNLCAwKSAgICAgICAgID0gMwpjb25uZWN0KDMsIHtzYV9mYW1pbHk9QUZfRklMRSwgcGF0aD0i
L3Zhci9ydW4vc2V0cmFucy8uc2V0cmFucy11bml4In0sIDExMCkgPSAwCnNlbmRtc2coMywge21z
Z19uYW1lKDApPU5VTEwsIG1zZ19pb3YoNSk9W3siXDNcMFwwXDAiLCA0fSwgeyJcMzJcMFwwXDAi
LCA0fSwgeyJcMVwwXDBcMCIsIDR9LCB7InJvb3Q6c3lzYWRtX3I6c3lzYWRtX3Q6czBcMCIsIDI2
fSwgeyJcMCIsIDF9XSwgbXNnX2NvbnRyb2xsZW49MCwgbXNnX2ZsYWdzPTB9LCBNU0dfTk9TSUdO
QUwpID0gMzkKcmVhZHYoMywgW3siXDNcMFwwXDAiLCA0fSwgeyJcMzJcMFwwXDAiLCA0fSwgeyJc
MFwwXDBcMCIsIDR9XSwgMykgPSAxMgpyZWFkdigzLCBbeyJyb290OnN5c2FkbV9yOnN5c2FkbV90
OnMwXDAiLCAyNn1dLCAxKSA9IDI2CmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA9IDAKb3BlbigiL3NlbGludXgvdXNlciIsIE9fUkRXUnxPX0xBUkdFRklMRSkgPSAzCndy
aXRlKDMsICJyb290OnN5c2FkbV9yOnN5c2FkbV90OnMwIHVzZXJfdSIsIDMyKSA9IDMyCnJlYWQo
MywgIjBcMCIsIDQwOTUpICAgICAgICAgICAgICAgICAgICA9IDIKY2xvc2UoMykgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgID0gMApvcGVuKCIvZXRjL3NlbGludXgvbWxzL2NvbnRleHRz
L2ZhaWxzYWZlX2NvbnRleHQiLCBPX1JET05MWXxPX0xBUkdFRklMRSkgPSAzCmZzdGF0NjQoMywg
e3N0X21vZGU9U19JRlJFR3wwNjQ0LCBzdF9zaXplPTIxLCAuLi59KSA9IDAKbW1hcDIoTlVMTCwg
NDA5NiwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9BTk9OWU1PVVMsIC0x
LCAwKSA9IDB4YjdmY2MwMDAKcmVhZCgzLCAic3lzYWRtX3I6c3lzYWRtX3Q6czBcbiIsIDQwOTYp
ID0gMjEKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMAptdW5tYXAo
MHhiN2ZjYzAwMCwgNDA5NikgICAgICAgICAgICAgICAgPSAwCnNvY2tldChQRl9GSUxFLCBTT0NL
X1NUUkVBTSwgMCkgICAgICAgICA9IDMKY29ubmVjdCgzLCB7c2FfZmFtaWx5PUFGX0ZJTEUsIHBh
dGg9Ii92YXIvcnVuL3NldHJhbnMvLnNldHJhbnMtdW5peCJ9LCAxMTApID0gMApzZW5kbXNnKDMs
IHttc2dfbmFtZSgwKT1OVUxMLCBtc2dfaW92KDUpPVt7IlwzXDBcMFwwIiwgNH0sIHsiXDM0XDBc
MFwwIiwgNH0sIHsiXDFcMFwwXDAiLCA0fSwgeyJ1c2VyX3U6c3lzYWRtX3I6c3lzYWRtX3Q6czBc
MCIsIDI4fSwgeyJcMCIsIDF9XSwgbXNnX2NvbnRyb2xsZW49MCwgbXNnX2ZsYWdzPTB9LCBNU0df
Tk9TSUdOQUwpID0gNDEKcmVhZHYoMywgW3siXDNcMFwwXDAiLCA0fSwgeyJcMzRcMFwwXDAiLCA0
fSwgeyJcMFwwXDBcMCIsIDR9XSwgMykgPSAxMgpyZWFkdigzLCBbeyJ1c2VyX3U6c3lzYWRtX3I6
c3lzYWRtX3Q6czBcMCIsIDI4fV0sIDEpID0gMjgKY2xvc2UoMykgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgID0gMApvcGVuKCIvc2VsaW51eC9jb250ZXh0IiwgT19SRFdSfE9fTEFSR0VG
SUxFKSA9IDMKd3JpdGUoMywgInVzZXJfdTpzeXNhZG1fcjpzeXNhZG1fdDpzMFwwIiwgMjgpID0g
LTEgRUlOVkFMIChJbnZhbGlkIGFyZ3VtZW50KQpjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPSAwCndyaXRlKDEsICJnZXRfZGVmYXVsdF9jb250ZXh0X3dpdGhfbGV2ZWwg
ZiIuLi4sIDU1KSA9IDU1CmV4aXRfZ3JvdXAoNTUpICAgICAgICAgICAgICAgICAgICAgICAgICA9
ID8K
------=_Part_136997_5174752.1184941090645--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
