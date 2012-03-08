MIME-Version: 1.0
Date: Thu, 8 Mar 2012 14:38:06 +0100
Message-ID: <CAGGozWRbYT9DFqjrpwxSjrZQiaePXAG5jx8ufJ2cVG7xWi+8Eg@mail.gmail.com>
Subject: [SEAndroid] checkpolicy missing
From: Bhargava Shastry <bshas3@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8f234567d729cb04babb6249
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8f234567d729cb04babb6249
Content-Type: text/plain; charset=ISO-8859-1

Hi,

After a repo sync, make clean and make of SEAndroid sources, I see the
following error:

make: *** No rule to make target `out/host/linux-x86/bin/checkpolicy',
needed by
`out/target/product/crespo/obj/ETC/sepolicy_intermediates/sepolicy.24'.
Stop.

Is the checkpolicy binary supposed to be part of the [SEAndroid] sources?
Apologies if I missed a detail on the wiki.


Thanks,
Bhargava Shastry

--e89a8f234567d729cb04babb6249
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>After a repo sync, make clean and make of SEAndroid sources, I s=
ee the following error:<br><br clear=3D"all">make: *** No rule to make targ=
et `out/host/linux-x86/bin/checkpolicy&#39;, needed by `out/target/product/=
crespo/obj/ETC/sepolicy_intermediates/sepolicy.24&#39;.=A0 Stop.<br>
<br>Is the checkpolicy binary supposed to be part of the [SEAndroid] source=
s? Apologies if I missed a detail on the wiki.<br><br><br>Thanks,<br>Bharga=
va Shastry<br>

--e89a8f234567d729cb04babb6249--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
