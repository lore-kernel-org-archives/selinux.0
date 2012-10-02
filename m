Message-ID: <506A4FC2.5010802@manicmethod.com>
Date: Mon, 01 Oct 2012 22:21:54 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Hayawardh Vijayakumar <hvijay@cse.psu.edu>
CC: SELinux@tycho.nsa.gov
Subject: Re: apol permission map weights
References: <CALS9afXC2gZGXyHupkGRySakK+Rmu1qBZ1FYNHSDiyynZqQSZQ@mail.gmail.com>
In-Reply-To: <CALS9afXC2gZGXyHupkGRySakK+Rmu1qBZ1FYNHSDiyynZqQSZQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hayawardh Vijayakumar wrote:
> Dear all,
>
> This is a question regarding the weights for the permission mappings
> from APOL (the file apol_perm_mapping_ver24 at e.g.,
> http://oss.tresys.com/repos/setools/trunk/apol/perm_maps/apol_perm_mapping_ver24).
> The documentation on page
> http://oss.tresys.com/projects/setools/wiki/helpFiles/iflow_help says
>
> "In addition to mapping each permission to read, write, both, or none,
> it is possible to assign the permission a weight between 1 and 10 (the
> default is 10).  Apol uses this weight to rate the importance of the
> information flow this permission represents and allows the user to
> make fine-grained distinctions between high-bandwidth, overt
> information flows and low-bandwidth, or difficult to exploit, covert
> information flows.  For example, the permissions "read" and "write" on
> the file object could be given a weight of 10 because they are very
> high-bandwidth information flows.  Additionally, the "use" permission
> on the fd object (file descriptor) would probably be given a weight of
> 1 as it is a very low-bandwidth covert flow at best. "
>
> However, the append permission on class file is given a weight of only
> 1, whereas write is given 10:
>
> class file 21
> ...
>              append	 w           1
> ...
>              write	         w          10
>
> Appending to a file causes a flow of as big a bandwidth as write. Can
> someone please explain why append is given so low a weight?

Probably an over site, I'll see about getting it fixed. Thanks for 
reporting it.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
