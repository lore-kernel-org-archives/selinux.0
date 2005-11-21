Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAL8MoMA009121
	for <selinux@tycho.nsa.gov>; Mon, 21 Nov 2005 03:22:51 -0500 (EST)
Received: from lon-del-02.spheriq.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAL8LGj2027739
	for <selinux@tycho.nsa.gov>; Mon, 21 Nov 2005 08:21:17 GMT
Received: from lon-out-01.spheriq.net ([195.46.50.129])
        by lon-del-02.spheriq.net with ESMTP id jAL8LjeI023886
        for <selinux@tycho.nsa.gov>; Mon, 21 Nov 2005 08:21:45 GMT
Received: from lon-cus-01.spheriq.net (lon-cus-01.spheriq.net [195.46.50.37])
        by lon-out-01.spheriq.net with ESMTP id jAL8Libj023168
        for <selinux@tycho.nsa.gov>; Mon, 21 Nov 2005 08:21:44 GMT
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by lon-cus-01.spheriq.net with ESMTP id jAL8Legg000861
        (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
        for <selinux@tycho.nsa.gov>; Mon, 21 Nov 2005 08:21:44 GMT
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 899E7DA52
	for <selinux@tycho.nsa.gov>; Mon, 21 Nov 2005 08:21:33 +0000 (GMT)
Received: from zeta.dmz-eu.st.com (localhost [127.0.0.1])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F325E759B2
	for <selinux@tycho.nsa.gov>; Mon, 21 Nov 2005 08:24:33 +0000 (UTC)
Received: from mail2.rou.st.com (mail2.rou.st.com [164.129.206.171])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C241A471EC
	for <selinux@tycho.nsa.gov>; Mon, 21 Nov 2005 08:24:32 +0000 (GMT)
Message-ID: <438183C1.5070403@st.com>
Date: Mon, 21 Nov 2005 09:22:25 +0100
From: Guillaume PETITJEAN <guillaume.petitjean@st.com>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: link between roles and domains
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I'm new to SELinux.

I have a question regarding the management of users and roles.

I understood that a user is associated with a role (or several roles) 
and that each role is allowed to enter a set of domain. I understood  
how access control permissions are defined on couple of domains and the 
process of domain transitions. But I didn't understand which domain 
(among the set of domains allowed for a role) is selected at any time.

In other terms let's say you have a process foo belonging to the role 
user_r and suppose user_r is allowed for (domain1_t, domain2_t, 
domain3_t), how does the policy decides to which domain will belong the 
process in practice in order to compute security decisions ?

Thanks

Guillaume Petitjean


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
