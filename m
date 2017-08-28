MIME-Version: 1.0
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Mon, 28 Aug 2017 14:58:37 -0700
Message-ID: <CABXk95BhYEZUQn74_H5Y0Ogxm23ZoLZA2Eiz22QTJwKG741B=Q@mail.gmail.com>
To: SELinux <Selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: sysfs symlinks in genfscon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Genfs_contexts does not label symlinks in sysfs, instead it leaves
them with the default “sysfs” label. Is this a bug?
