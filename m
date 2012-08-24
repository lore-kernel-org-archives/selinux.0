Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7OGImcK026905
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2012 12:18:48 -0400
Received: by vcbfl17 with SMTP id fl17so2754339vcb.12
        for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2012 09:18:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201208211615.q7LGFg3M000832@vivaldi49.register.it>
References: <201208211615.q7LGFg3M000832@vivaldi49.register.it>
Date: Fri, 24 Aug 2012 18:18:46 +0200
Message-ID: <CAPzO=Nyqc0=cyeOh6Aj3A-bSbtpbnjSfsXc_Lf-kO3ceeK3w2A@mail.gmail.com>
Subject: Re: [PATCH/RFC] setools: update swig interfaces for swig-2.0.7 (and higher?)
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 21, 2012 at 6:15 PM, Guido Trentalancia
<guido@trentalancia.com> wrote:
> For your information. Apparently swig version 2.0.8 has been just released...

Tried it, no luck, same errors:

apol_wrap.c: At top level:
apol_wrap.c:5296:33: error: conflicting types for
'apol_types_relation_result_get_attributes'
../../../libapol/include/apol/types-relation-analysis.h:164:30: note:
previous declaration of 'apol_types_relation_result_get_attributes'
was here
apol_wrap.c:5299:33: error: conflicting types for
'apol_types_relation_result_get_roles'
../../../libapol/include/apol/types-relation-analysis.h:176:30: note:
previous declaration of 'apol_types_relation_result_get_roles' was
here
apol_wrap.c:5302:33: error: conflicting types for
'apol_types_relation_result_get_users'
../../../libapol/include/apol/types-relation-analysis.h:188:30: note:
previous declaration of 'apol_types_relation_result_get_users' was
here
apol_wrap.c:5305:33: error: conflicting types for
'apol_types_relation_result_get_similar_first'

Etc...

With the mentioned patch, it builds fine.

Wkr,
  Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
