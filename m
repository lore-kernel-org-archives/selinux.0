Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l66GrqQN003226
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2007 12:53:52 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l66Grpng023078
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2007 16:53:51 GMT
Message-ID: <468E7356.5080207@redhat.com>
Date: Fri, 06 Jul 2007 12:52:38 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: joe.rocklin@ngc.com
Subject: [Fwd: libsemanage API]
Content-Type: multipart/mixed;
 boundary="------------030405090807060000060800"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030405090807060000060800
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable



-------- Original Message --------
Subject: 	libsemanage API
Date: 	Fri, 06 Jul 2007 10:59:23 -0400
From: 	Joe Rocklin <joe.rocklin@ngc.com>
To: 	dwalsh@redhat.com



Hi Dan,

I'm trying to use the API to libsemanage from C++, and I'm running into=20
some difficulties finding relevant documentation on the subject.  If you =

could point me in the right direction, I'd really appreciate it!

The issue I'm having is with trying to work with the return results from =

semanage_user_list.  The struct defines for semanage_user_t (as well as=20
semanage_user_base_t  and semanage_user_extra_t) are in the .c files,=20
not the header files, which causes a compile to fail with the following=20
error:


    setest.cpp:19: error: request for member =E2=80=98name=E2=80=99 in
    =E2=80=98*(((semanage_user_t**)(((unsigned int)i) * 4u)) + list)=E2=80=
=99, which is
    of non-class type =E2=80=98semanage_user_t*=E2=80=99

I've attached the small program used to test this.  If I run this in ddd =

and display the variable list[0].name it correctly displays the=20
contents.  I believe the issue is that the compiler isn't aware of the=20
struct definition, which isn't presented until the link phase.

Is there another way of accessing this data?  Or is the correct answer=20
to move the struct definitions into the header files?

--Joe

--------------030405090807060000060800
Content-Type: text/x-c++src;
 name="setest.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setest.cpp"

extern "C" {
	#include <semanage/semanage.h>
}
#include <iostream>

using namespace std;

int main (int argc, char **argv) {
	semanage_handle_t *sh = semanage_handle_create();

	semanage_user_t **list;
	unsigned int count;

	semanage_connect(sh);

	semanage_user_list(sh, &list, &count);

	for (int i = 0; i < count; i++) {
		cout << i << ": " << list[i].name << endl;
	}

	return 0;
}

--------------030405090807060000060800--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
