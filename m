Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB1Mpq20019868
	for <selinux@tycho.nsa.gov>; Tue, 1 Dec 2009 17:51:52 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nB1Ms4Y6027077
	for <selinux@tycho.nsa.gov>; Tue, 1 Dec 2009 22:54:05 GMT
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nB1Mpo9N028227
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 1 Dec 2009 17:51:50 -0500
Received: from localhost.localdomain (vpn-10-209.rdu.redhat.com [10.11.10.209])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nB1Mpnvh005267
	for <selinux@tycho.nsa.gov>; Tue, 1 Dec 2009 17:51:50 -0500
Message-ID: <4B159E05.50409@redhat.com>
Date: Tue, 01 Dec 2009 17:51:49 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: A question about genhomedircon
References: <87vdh5kp0s.fsf@anzu.internal.golden-gryphon.com>	<1258747888.27504.624.camel@gorn.columbia.tresys.com> <87iqcvwfw2.fsf@anzu.internal.golden-gryphon.com>
In-Reply-To: <87iqcvwfw2.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/27/2009 09:18 PM, Manoj Srivastava wrote:
> On Fri, Nov 20 2009, Christopher J. PeBenito wrote:
> 
> 
>> Theres no need to reload the policy, as the policy isn't changing.  It
>> does, however, regenerate the file contexts, including the home dir
>> contexts.
> 
>         So the behaviour has not changed? In which case, can we bring
>  back the  man page for the command?
> 
>         manoj
Sounds good to me.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
