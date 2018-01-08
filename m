Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w08FB0xu009716
 for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2018 10:11:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 93B19C056789
 for <selinux@tycho.nsa.gov>; Mon,  8 Jan 2018 15:10:44 +0000 (UTC)
Received: from [10.43.12.77] (unknown [10.43.12.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37E305C3F9
 for <selinux@tycho.nsa.gov>; Mon,  8 Jan 2018 15:10:43 +0000 (UTC)
To: SELinux <selinux@tycho.nsa.gov>
From: Vit Mojzis <vmojzis@redhat.com>
Message-ID: <2f76cc8e-b5a5-024e-2c60-baff93fa0bb9@redhat.com>
Date: Mon, 8 Jan 2018 16:10:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: selabel_lookup() with MEDIA backend issue
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,
there seems to be a discrepancy between man page and actual behavior of 
selabel_lookup() with MEDIA backend.
selabel_media man page says:
     "Should there not be a valid entry in the media file, then the 
default removable_context file will be read (see removable_context(5))."

but the removable_context file is never used (for more details and a 
reproducer see https://bugzilla.redhat.com/show_bug.cgi?id=1395621).

I can see two possible solutions:
   1) Remove the removable_context file and adjust man pages accordingly.

   2) (Probably better) Add mechanism for using the removable_context

Which one would you prefer?

In case of the latter, would adding the content of removable_context 
file to saved_data->spec_arr[nspec + 1] (label_media.c) and returning it 
in case lookup fails be a reasonable solution?

Thank you.

Vit Mojzis
