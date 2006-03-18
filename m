Message-ID: <441C3B52.7060702@redhat.com>
Date: Sat, 18 Mar 2006 11:54:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Changes to policycoreutils.
References: <441B2C7B.7050307@redhat.com> <200603180532.k2I5Wuhe004158@turing-police.cc.vt.edu>
In-Reply-To: <200603180532.k2I5Wuhe004158@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:
> On Fri, 17 Mar 2006 16:39:07 EST, Daniel J Walsh said:
>
>   
>> This will give us the ability of instantly labeling the ~/public_html 
>> directory.  So if a user logs in and does a
>> mkdir ~/public_html to tool will label the file correctly.
>>     
>
> Do you have an estimate on how fast "instantly" is?  A few second's delay in
> relabelling ~/public_html is probably not a big thing, but a delay in
> relabelling a just-created file to a more restrictive context may be opening a
> timing hole (for instance, allowing the grabbing of a just-created GPG or SSH
> key before the door is closed).
>
> I'm suspecting the answer is "there's a small hard-to-hit hole" that people
> find acceptable risk (which I'm OK on, as long as we're honest about the size
> of the risk and how it works....)
>
>   
The answer is that is, if the file is created by a confined domain it 
will be instantly.  SELinux
aware application also create it instantly.  This is more for the non 
SELinux aware applicaitons. 
So the example of the user creating the public_html directory. 

It happens very fast, as a matter of fact you can try this command to see it

rmdir public_html; mkdir public_html; ls -ldZ public_html
drwxrwxr-x  dwalsh   dwalsh   user_u:object_r:httpd_sys_content_t 
public_html

This should not be considered a failsafe security measure, but more of a 
usability issue.
If you have an file that is of critical secuirty you might not want to 
use this tool on it.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
