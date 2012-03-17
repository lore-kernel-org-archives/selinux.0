Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2HLjYVU007130
	for <selinux@tycho.nsa.gov>; Sat, 17 Mar 2012 17:45:34 -0400
Received: by dady25 with SMTP id y25so7472151dad.12
        for <selinux@tycho.nsa.gov>; Sat, 17 Mar 2012 14:45:33 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 17 Mar 2012 14:45:33 -0700
Message-ID: <CAFftDdonw_shpO3o1+AE0aYH5gaWBPQxP_=jW4x6-fVXsz6pug@mail.gmail.com>
Subject: SE Linux file system relabel
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b1601bbadb86b04bb773ee7
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b1601bbadb86b04bb773ee7
Content-Type: text/plain; charset=ISO-8859-1

I just stood SE Android up on a Maguro device. I have reviewed the patches
submitted to the mailing list, but I would like to understand how to do
some of this myself. I am trying to label the /factory files, currently
the factory files are labeled as:

drwxrwxr-x radio    radio             u:object_r:unlabeled:s0 factory

I modified sepolicy/attributes and included this line:

#All types used for /factory files.
attribute factory_type;

I then created sepolicy/factory.te file that is this:
type factory, factory_type;

I then modified sepolicy/file_contexts to include
# factory files
/factory(/.*)?  u:object_r:factory:s0

I am trying to figure out how to label that part of the filesystem from
scratch so I can understand the process a little better. Thanks for any
help!

-- 
Respectfully,

William C Roberts

--047d7b1601bbadb86b04bb773ee7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span style>I just stood SE Android up on a Maguro device. I have reviewed =
the patches submitted to the mailing list, but I would like to understand h=
ow to do some of this myself. I am trying to label the /factory files, curr=
ently the=A0factory=A0files are=A0labeled=A0as:</span><div style>
<br clear=3D"all"><div><div>drwxrwxr-x radio =A0 =A0radio =A0 =A0 =A0 =A0 =
=A0 =A0 u:object_r:unlabeled:s0 factory</div></div><div><br></div><div>I mo=
dified sepolicy/attributes and included this line:</div><div><br></div><div=
>#All types used for /factory files.</div>
<div>attribute factory_type;</div><div>=A0</div><div>I then created sepolic=
y/factory.te file that is this:</div><div>type factory, factory_type;<br></=
div><div><br></div><div>I then modified sepolicy/file_contexts to include</=
div>
<div><div># factory files</div><div>/factory(/.*)? =A0u:object_r:factory:s0=
</div></div><div><br></div><div>I am trying to figure out how to label that=
 part of the filesystem from scratch so I can understand the process a litt=
le better. Thanks for any help!</div>
</div><div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><=
br>

--047d7b1601bbadb86b04bb773ee7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
