Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4KDfXps000655
 for <selinux@tycho.nsa.gov>; Tue, 20 May 2014 09:41:33 -0400
Message-ID: <537B5BD3.4090507@tresys.com>
Date: Tue, 20 May 2014 09:42:43 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: Significance of SELinux user and roles on objects.
References: <537AE191.7070403@gmail.com>
In-Reply-To: <537AE191.7070403@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/20/2014 01:01 AM, dE wrote:
> I've read that the roles on objects (like files) are in reality of no use and are filled up just for the sake of filling. That's why every file has role object_r.
> 
> Which prompts me a question -- do the user and role of objects (like files) have any significance? Or can access be allowed/denied based on the object's role and user?

Roles on objects typically don't have any use.  The kernel will create files with object_r regardless, so putting a role on a file can't easily be made useful right now.  For example, I added user_tmp_t to the user_r so I could label a directory:

$ chcon user_u:user_r:user_tmp_t .
$ ls -laZ
total 12K
drwxr-xr-x.   2 pebenito users user_u:user_r:user_tmp_t    6 May 20 09:25 .
drwxrwxrwt. 127 root     root  system_u:object_r:tmp_t  8.0K May 20 09:25 ..

And then I touch a file:

$ touch test
$ ls -laZ
total 12K
drwxr-xr-x.   2 pebenito users user_u:user_r:user_tmp_t     17 May 20 09:27 .
drwxrwxrwt. 127 root     root  system_u:object_r:tmp_t    8.0K May 20 09:25 ..
-rw-r--r--.   1 pebenito users user_u:object_r:user_tmp_t    0 May 20 09:27 test

So the new file still gets object_r instead of user_r.  If you do have a role on an object, you can write constraints in the policy based on the role of the object.  If the role was correctly set on objects, I would use the role on objects to enforce role separations in refpolicy.

The user is useful on some objects, as the basic constraints in refpolicy will deny creating or relabeling a file if the user of the process doesn't match the user of the file.  If you have UBAC turned on in refpolicy, then the user separations will be enforced across all relevant object classes.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
