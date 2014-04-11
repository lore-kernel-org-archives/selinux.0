Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3B6lvxI004748
 for <selinux@tycho.nsa.gov>; Fri, 11 Apr 2014 02:47:57 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so5033761pab.27
 for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2014 23:47:42 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.94.237])
 by mx.google.com with ESMTPSA id y4sm13372908pbk.76.2014.04.10.23.47.40
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 10 Apr 2014 23:47:41 -0700 (PDT)
Message-ID: <53478F76.7040700@gmail.com>
Date: Fri, 11 Apr 2014 12:15:10 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Security server responses always based on class?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Does the object manager always queries the security server based on 
classes? And does the security server always respond with an access vector?

OR

Can the object manager query the security server on specific permissions 
(which make up a class) without querying for a response for the whole 
security class?
